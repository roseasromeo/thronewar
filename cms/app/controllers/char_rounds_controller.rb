class CharRoundsController < ApplicationController
  def new
    @user = current_user
    @game = Game.find(params[:game_id])
    @player = true
    if params[:display_toggle] != nil
      @display_toggle = (params[:display_toggle] == "true")
    else
      @display_toggle = true
    end
    if @game.preparing?
      redirect_to game_path(@game)
    elsif @game.started?
      @character = @game.characters.where(user: @user).first

      get_auction
      get_current_round
      if @current_round != nil && @current_round.number != 1
        @all_closed = all_items_closed?
      else
        @all_closed = false
      end

      if @all_closed
        @message = "This auction is finished. Please wait for the Arbiter to continue."
      elsif @items == nil
        @message = "Please wait for the Arbiter to start the next Auction."
      elsif pledge_made?
        @message = "Your pledge has been submitted. Please wait for the next round to start."
      elsif @character == nil
        @message = "This user account does not have a character for this auction."
      else
        @message = nil
        @char_round = CharRound.new(round: @current_round, character: @character)
        @items.count.times do
          @char_round.pledges.build
        end
        if @current_round.number != 1
          @last_char_round = @auction.char_rounds.where(character: @character, round: @last_round).first
          @last_pledges = @last_char_round.pledges
        else
          @last_pledges = nil
        end
      end
    else
      #game.complete?
      redirect_to game_path(@game)
    end
  end

  def create
    @game = Game.find(params[:game_id])
    @user = current_user
    @character = @game.characters.where(user: @user).first
    @player = true
    max_points = 120
    get_auction
    get_current_round
    @all_closed = all_items_closed?
    if CharRound.where(character: @character, round: @current_round).empty? && !@all_closed
      @char_round = CharRound.new(character: @character, round: @current_round)
      if @char_round.save
        @pledge_values = []
        params[:char_round][:pledges_attributes].values.each do |pledge|
          @pledge_values << pledge[:value]
        end if params[:char_round] and params[:char_round][:pledges_attributes]
        @item_counter = 0
        @errors = ActiveModel::Errors.new(@char_round)
        pledge_total = 0
        @items.each do |item|
          @pledge = Pledge.new(char_round: @char_round, character: @character, item: item, value: @pledge_values[@item_counter])
          @item_counter = @item_counter + 1
          pledge_change = pledge_validate(item)
          if @errors.empty? && @pledge.save
            # do nothing
          else
            @pledge.errors.full_messages.each do |msg|
              @errors[:base] << ("Pledge error: #{msg}")
            end
          end
          if @errors.empty?
            pledge_total = pledge_total + pledge_change
          end
        end
        if (@character.points_spent + pledge_total) > max_points
          @errors[:base] << ("Current pledges will cause points spent on all auctions to exceed maximum points possible to spend.")
        end
        if @errors[:base].empty?
          redirect_to game_player_path(@game)
        else
          @char_round.destroy #delete the CharRound if there are any errors
          if @char_round.pledges.count < @items.count
            (@items.count - @char_round.pledges.count).times do
              @char_round.pledges.build
            end
          end
          flash[:error] = @errors
          render 'new', :pledge_values => @pledge_values
        end
      else
        @errors = @char_round.errors
        render 'new'
      end
    else
      @errors = ActiveModel::Errors.new(@char_round)
      if @all_closed
        @errors[:base] << ("This auction is finished. Please wait for the Arbiter to continue.")
      else
        @errors[:base] << ("Pledges for this round already submitted. Please wait.")
      end
      redirect_to game_player_path(@game), :flash => { :error => @errors }
    end
  end

  def destroy
    if gm_user?
      @game = Game.find(params[:game_id])
      @char_round = CharRound.find(params[:id])
      @char_round.destroy

      redirect_to gm_game_path(@game)
    else
      redirect_to '/'
    end
  end

  private
    def char_rounds_params
      params.require(:char_round).permit(:character, :round, pledges_attributes: [:id, :value, :_destroy])
    end

    def pledge_made?
      !CharRound.where(character: @character, round: @current_round).empty?
    end

    def pledge_validate(item)
      aspect_min_pledge = 5
      gift_min_pledge = 15
      maximum_opening_pledge = 30
      if item.auction.aspect?
        min_pledge = aspect_min_pledge
      else
        min_pledge = gift_min_pledge
      end
      auction = @auction
      character = @character
      current_round = @current_round
      pledge_value = @pledge.value
      round_number = current_round.number
      # Pledge must either be 0 or greater than or equal to minimum pledge
      if pledge_value == nil
        # pledge cannot be nil
        pledge_value = 0
        @errors[:base] << ("#{item.name} pledge must be a positive whole number.")
      elsif pledge_value < 0
        @errors[:base] << ("#{item.name} pledge may not be negative.")
      elsif pledge_value > 0 && pledge_value < min_pledge
        @errors[:base] << ("#{item.name} pledge may be at least the minimum pledge of #{min_pledge}.")
      end
      if round_number != 1
        last_round = Round.where(auction: auction, number: round_number - 1).first
        compare_pledges = last_round.pledges.where(item: item)
        if compare_pledges.where(value: pledge_value, character: character).empty?
          # The pledge is not a continuting bid
          max_last = compare_pledges.maximum(:value)
          if item.closed?
            # Pledge may not change in closed items
            @errors[:base] << ("#{item.name} pledge may not change once the item is closed.")
          elsif !compare_pledges.where(value: pledge_value).empty? && pledge_value != min_pledge
            # Placed pledge that matched previous round pledge, not from blind tie, and not from entering item
            @errors[:base] << ("#{item.name} pledge may not tie a pledge from a different character in the previous round.")
          elsif !compare_pledges.where(value: max_last, character: character).empty? && pledge_value > max_last + 5 && pledge_value != min_pledge
            # Outbid self by more than 5 at 1st rank
            @errors[:base] << ("1st rank in #{item.name} may not pledge more than 5 points over previous pledge.")
          elsif pledge_value > max_last + 10 && pledge_value != min_pledge
            # Outbid max by more than 10
            @errors[:base] << ("#{item.name} pledge may not exceed 10 points over previous 1st rank pledge.")
          elsif compare_pledges.where(character: character).first.value > pledge_value
            # Pledge may not be lowered
            @errors[:base] << ("#{item.name} pledge may not be lowered from previous pledge.")
          end
        end

        pledge_change = pledge_value - compare_pledges.where(character: character).first.value
      else #i.e. round number is 1
        # In the opening round, pledge may not be larger than maximum opening bid
        pledge_change = pledge_value
        if pledge_value > maximum_opening_pledge
          @errors[:base] << ("#{item.name} pledge may not be greater than the maximum opening pledge #{maximum_opening_pledge}.")
        end
      end
      pledge_change
    end

end
