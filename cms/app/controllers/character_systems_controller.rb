class CharacterSystemsController < ApplicationController
  require 'csv'

  def index
    if gm_user?
      @character_systems = CharacterSystem.all
    else
      redirect_to '/'
    end
  end

  def show
    if logged_in?
      @user = current_user
      @character_system = CharacterSystem.find(params[:id])
      if !gm_user? && @character_system.final_characters.where(user: @user).empty?
        redirect_to '/'
      else
        @final_characters = @character_system.final_characters
        @final_character = @final_characters.where(user: @user).first
      end
    else
      redirect_to login_path
    end
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
    @game = Game.find(params[:character_system][:game_id])
    @character_system = CharacterSystem.new(game: @game, title: params[:character_system][:title], description: params[:character_system][:description], status: :preparing)
    if @character_system.save
      @characters = @game.characters
      @aspect_auction = @game.auctions.aspect.first
      @gift_auction = @game.auctions.gift.first
      @errors = ActiveModel::Errors.new(@character_system)
      default_flaws
      @characters.each do |character|
        user = character.user

        final_character = FinalCharacter.new(character_system: @character_system, user: user, approval: :not_submitted)
        if final_character.save
          items = @aspect_auction.items
          round = @aspect_auction.rounds.order(number: :desc).first
          if round.pledges.empty?
            round = @aspect_auction.rounds.order(number: :desc).second
          end
          items.each do |item|
            create_ranks(item, round, character, final_character)
          end

          items = @gift_auction.items
          round = @gift_auction.rounds.order(number: :desc).first
          if round.pledges.empty?
            round = @gift_auction.rounds.order(number: :desc).second
          end
          items.each do |item|
            create_ranks(item, round, character, final_character)
          end
          final_character.save
        else
          final_character.errors.full_messages.each do |msg|
            @errors[:base] << ("Final Character error: #{msg}")
          end
        end
      end
      if @errors.empty?
        redirect_to character_system_path(@character_system)
      else
        @character_system.destroy
        flash[:error] = @errors
        render 'new'
      end
    else
      @errors = @character_system.errors
      flash[:error] = @errors
      render 'new'
    end
  end

  private
    def default_flaws
      filename = Rails.root + 'app/assets/files/flaws.utf8.csv'
      CSV.foreach(filename, :headers => true) do |row|
        row_hash = row.to_hash
        flaw = Flaw.new(character_system: @character_system, name: row_hash['name'], description: row_hash['description'], link: row_hash['link'])
        if flaw.save
          # do nothing
        else
          flaw.errors.full_messages.each do |msg|
            @errors[:base] << ("Flaw error: #{msg}")
          end
        end
      end
    end

    def create_ranks(item, round, character, final_character)
      item_name = item.name
      pledge = round.pledges.where(item: item, character: character).first
      rank = Rank.new(final_character: final_character, item: item_name, public_points: pledge.value, private_points: pledge.value, public_rank: pledge.rank, private_rank: pledge.rank)

      if rank.save
        # do nothing
      else
        rank.errors.full_messages.each do |msg|
          @errors[:base] << ("Start Rank #{item_name} error: #{msg}")
        end
      end
    end
end