class CharacterSystemsController < ApplicationController
  def index
  end

  def show
  end

  def new
    if logged_in?
      if gm_user?
        @character_system = CharacterSystem.new
        @game = Game.find(params[:game_id])
        @character_system.game = @game
        if !@game.complete?
          redirect_to game_path(@game)
        end
      else
        redirect_to '/'
      end
    else
      redirect_to login_path
    end
  end

  def create
    @game = Game.find(params[:game_id])
    @character_system = CharacterSystem.new(game: @game, title: params[:title], description: params[:description], status: :preparing)
    if @character_system.save
      @characters = @game.characters
      @aspect_auction = @game.auctions.aspect.first
      @gift_auction = @game.auctions.gift.first
      @errors = ActiveModel::Errors.new(@character_system)
      @characters.each do |character|
        user = character.user

        final_character = FinalCharacter.new(character_system: @character_system, user: user, approval: :not_submitted)
        if final_character.save
          items = [ :battle, :cunning, :destiny, :ego, :flesh, :command, :change, :illusion, :gutter_magic ]
          items.each do |item_name|
            if @aspect_auction.items.where(name: item_name).first != nil
              item = @aspect_auction.items.where(name: item_name).first
            else
              item = @gift_auction.items.where(name: item_name).first
            end
            pledge = character.pledges.where(item_name: item).order(round_number: :desc).first
            start_rank = StartRank.new(final_character: final_character, item: item_name, points: pledge.points, rank: pledge.rank)
            final_rank = FinalRank.new(final_character: final_character, item: item_name, points: pledge.points, rank: pledge.rank, half: false)
            if start_rank.save
              # do nothing
            else
              start_rank.errors.full_messages.each do |msg|
                @errors[:base] << ("Start Rank #{item_name} error: #{msg}")
              end
            end
            if final_rank.save
              # do nothing
            else
              final_rank.errors.full_messages.each do |msg|
                @errors[:base] << ("Final Rank #{item_name} error: #{msg}")
              end
            end
          end
        else
          final_character.errors.full_messages.each do |msg|
            @errors[:base] << ("Final Character error: #{msg}")
          end
        end
        if @errors.empty?
          redirect_to character_system_path(@character_system)
        else
          @character_system.destroy
          flash[:error] = @errors
          render 'new'
        end
      end
    else
      @errors = @character_system.errors
      flash[:error] = @errors
      render 'new'
    end
  end

  private
    def game_params
      params.require(:character_system).permit(:title, :description, :game)
    end

    def default_flaws

end
