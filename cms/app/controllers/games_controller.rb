class GamesController < ApplicationController
  def index
    if logged_in?
      @games = Game.all
    else
      redirect_to login_path
    end
  end

  def show
    if logged_in?
      @user = current_user
      @game = Game.find(params[:id])
      @new_character = @game.characters.where(user: @user).empty?
      @characters = @game.characters
      if !@new_character
        @character = @game.characters.where(user: @user).first
      end
      if @game.complete?
        get_auction
        get_current_round
        if params[:display_toggle] != nil
          @display_toggle = (params[:display_toggle] == "true")
        else
          @display_toggle = true
        end
        @no_character_system = CharacterSystem.where(game: @game).empty?
      end
    else
      redirect_to login_path
    end
  end

  def new
    if gm_user?
      @game = Game.new
    else
      redirect_to '/'
    end
  end


  def create
    if logged_in?
      if gm_user?
        @game = Game.new(game_params)

        if @game.save
          redirect_to @game
        else
          render 'new'
        end
      else
        redirect_to '/'
      end
    else
      redirect_to login_path
    end
  end

  def start
    @game = Game.find(params[:id])
    if gm_user? && @game.preparing?
      @game.started!
      redirect_to gm_game_path(@game)
    else
      redirect_to game_path(@game)
    end
  end

  def gm
    if gm_user?
      @user = current_user
      @game = Game.find(params[:id])
      @player = false
      if params[:display_toggle] != nil
        @display_toggle = (params[:display_toggle] == "true")
      else
        @display_toggle = true
      end
      if @game.preparing?
        redirect_to game_path(@game)
      elsif @game.started?
        get_auction
        get_current_round
        @all_pledges_in = all_pledges_in?
        if @current_round != nil && @last_round !=nil
          @all_closed = all_items_closed?
        else
          @all_closed = false
        end
      else
        # @game.complete?
        redirect_to game_path(@game)
      end
    else
      redirect_to '/'
    end
  end

  def aspect
    @game = Game.find(params[:id])
    @auction = Auction.new(game: @game, phase: :aspect)
    @player = false
    if @auction.save
      # Create the round
      @round = Round.new(auction: @auction, number: 1)
      if !(@round.save)
        @errors = @round.errors
      end
      # Create the Aspect Items
      @battle = Item.new(auction: @auction, name: :battle)
      if !(@battle.save)
        @battle.errors.full_messages.each do |msg|
          @errors[:base] << ("Battle error: #{msg}")
        end
      end
      @cunning = Item.new(auction: @auction, name: :cunning)
      if !(@cunning.save)
        @cunning.errors.full_messages.each do |msg|
          @errors[:base] << ("Cunning error: #{msg}")
        end
      end
      @destiny = Item.new(auction: @auction, name: :destiny)
      if !(@destiny.save)
        @destiny.errors.full_messages.each do |msg|
          @errors[:base] << ("Destiny error: #{msg}")
        end
      end
      @ego = Item.new(auction: @auction, name: :ego)
      if !(@ego.save)
        @ego.errors.full_messages.each do |msg|
          @errors[:base] << ("Ego error: #{msg}")
        end
      end
      @flesh = Item.new(auction: @auction, name: :flesh)
      if !(@flesh.save)
        @flesh.errors.full_messages.each do |msg|
          @errors[:base] << ("Flesh error: #{msg}")
        end
      end
      redirect_to gm_game_path, :flash => { :error => @errors }
    else
      redirect_to '/' #this is just wrong
    end
  end

  def gift
    @game = Game.find(params[:id])
    @auction = Auction.new(game: @game, phase: :gift)
    @player = false
    if @auction.save
      # Create the round
      @round = Round.new(auction: @auction, number: 1)
      if !(@round.save)
        @errors = @round.errors
      end
      # Create the Aspect Items
      @command = Item.new(auction: @auction, name: :command)
      if !(@command.save)
        @command.errors.full_messages.each do |msg|
          @errors[:base] << ("Command error: #{msg}")
        end
      end
      @change = Item.new(auction: @auction, name: :change)
      if !(@change.save)
        @change.errors.full_messages.each do |msg|
          @errors[:base] << ("Change error: #{msg}")
        end
      end
      @illusion = Item.new(auction: @auction, name: :illusion)
      if !(@illusion.save)
        @illusion.errors.full_messages.each do |msg|
          @errors[:base] << ("Illusion error: #{msg}")
        end
      end
      @guttermagic = Item.new(auction: @auction, name: :gutter_magic)
      if !(@guttermagic.save)
        @guttermagic.errors.full_messages.each do |msg|
          @errors[:base] << ("Gutter Magic error: #{msg}")
        end
      end
      redirect_to gm_game_path, :flash => { :error => @errors }
    else
      redirect_to '/' #this is just wrong
    end
  end

  def close
    if gm_user?
      @game = Game.find(params[:id])
      @current_round = Round.find(params[:current_round])
      @player = false
      assign_ranks
      set_points_spent
      @all_closed = false
      if @current_round.number != 1
        get_auction
        get_current_round
        check_for_strikes
        @all_closed = all_items_closed?
      end
      @auction = Auction.find(params[:auction])
      if @all_closed
        redirect_to gm_game_path, :all_closed => @all_closed
      else
        new_round_number = @current_round.number + 1
        @round = Round.new(auction: @auction, number: new_round_number)
        if @round.save
          redirect_to gm_game_path, :all_closed => @all_closed
        else
          @errors = @round.errors
          redirect_to gm_game_path, :flash => { :error => @errors }
        end
      end
    else
      redirect_to '/'
    end
  end

  def close_auction
    if gm_user?
      @auction = Auction.find(params[:auction])
      @auction.closed = true
      @player = false
      if @auction.save
        if @auction.gift?
          @auction.game.complete!
          redirect_to gm_game_path
        else
          redirect_to gm_game_path
        end
      else
        @errors = @auction.errors
        redirect_to gm_game_path, :flash => { :error => @errors }
      end
    else
      redirect_to '/'
    end
  end

  def display
    @game = Game.find(params[:id])
    if params[:display_toggle] == "true"
      @display_toggle = false
    else
      @display_toggle = true
    end
    if params[:player] == "true"
      if @game.started?
        redirect_to game_player_path(@game, :display_toggle => @display_toggle)
      else
        redirect_to game_path(@game, :display_toggle => @display_toggle)
      end
    else
      if @game.started?
        redirect_to gm_game_path(@game, :display_toggle => @display_toggle)
      else
        redirect_to game_path(@game, :display_toggle => @display_toggle)
      end
    end
  end

  private
    def game_params
      params.require(:game).permit(:title)
    end

    def all_pledges_in?
      # checks to see if there is a CharRound for each character
      # for the current round
      all_pledges = true
      if @current_round != nil
        @characters.each do |character|
          if @current_round.char_rounds.where(character: character).empty?
            all_pledges = false
          end
        end
      else
        all_pledges = false
      end
      all_pledges
    end

    def assign_ranks
      current_round = @current_round
      items = current_round.items
      items.each do |item|
        pledges_for_item = current_round.pledges.where(item: item)
        ordered_pledges = pledges_for_item.order(:value)
        rank = 1
        max = 10
        while !ordered_pledges.empty? && rank < 10 && max > 0
          max = ordered_pledges.maximum(:value)
          if max != 0
            max_pledges = ordered_pledges.where(value: max)
            max_pledges.each do |pledge|
              pledge.rank = rank
              pledge.save
            end
            rank = rank + 1
            ordered_pledges = ordered_pledges.where.not(value: max)
          end
        end
      end
    end

    def check_for_strikes
      current_round = @current_round
      last_round = @last_round

      items = last_round.items
      items.each do |item|
        if item.closed?
          # no more strikes
        else
          current_pledges = current_round.pledges.where(item: item)
          last_pledges = last_round.pledges.where(item: item)
          current_max = current_pledges.maximum(:value)
          last_max = last_pledges.maximum(:value)

          current_ranks = []
          current_pledges.order(rank: :asc).each do |pledge|
            current_ranks << pledge.rank
          end

          last_ranks = []
          last_pledges.order(rank: :asc).each do |pledge|
            last_ranks << pledge.rank
          end

          if current_max > last_max
            # no strike--in this scenario, ranks changed or highest increased
          elsif compare_arrays(current_ranks, last_ranks)
            # if the ranks are equal, a strike may happen, otherwise no strike possible
            current_chars = []
            current_pledges.order(rank: :asc, character_id: :asc).each do |pledge|
              current_chars << pledge.character.id
            end

            last_chars = []
            last_pledges.order(rank: :asc, character_id: :asc).each do |pledge|
              last_chars << pledge.character.id
            end

            if compare_arrays(current_chars, last_chars)
              # if the order of the ranks is the same and the order of the characters is the same
              # strike!
              item.num_strikes = item.num_strikes + 1
              item.save
              if item.num_strikes >= 3
                item.closed = true
                item.save
              end
            end

          end
        end
      end
    end

    def compare_arrays(array1, array2)
      same = true
      if array1.count != array2.count
        same = false
      else
        array1.count.times do |i|
          same = same && (array1[i] == array2[i])
        end
      end
      same
    end

    def set_points_spent
      auctions = @game.auctions
      aspect_auction = auctions.aspect.first
      aspect_exists = (aspect_auction != nil)
      if aspect_exists
        current_aspect_round = aspect_auction.rounds.order(number: :desc).first
        aspect_items = aspect_auction.items
      end
      gift_auction = auctions.gift.first
      gift_exists = (gift_auction != nil)
      if gift_exists
        current_gift_round = gift_auction.rounds.order(number: :desc).first
        gift_items = gift_auction.items
      end

      @game.characters.each do |character|
        points_spent = 0
        if aspect_exists
          current_aspect_round.pledges.where(character: character).each do |pledge|
            points_spent = points_spent + pledge.value
          end
        end
        if gift_exists
          current_gift_round.pledges.where(character: character).each do |pledge|
            points_spent = points_spent + pledge.value
          end
        end
        character.points_spent = points_spent
        character.save
      end
    end

end
