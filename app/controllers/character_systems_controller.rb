class CharacterSystemsController < ApplicationController
  require 'csv'
  before_action :set_character_system, only: [:show, :edit, :update, :destroy, :complete]

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
      if !gm_user? && @character_system.final_characters.where(user: @user).empty? && !character_system.completed?
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
        @edit = false
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

  def edit
    if gm_user?
      @edit = true
    else
      redirect_to [@character_system]
    end
  end

  def create
    @game = Game.find(character_system_params[:game_id])
    @character_system = CharacterSystem.new(game: @game, title: character_system_params[:title], description: character_system_params[:description], status: :preparing)
    @edit = false
    if @character_system.save
      @characters = @game.characters
      @aspect_auction = @game.auctions.aspect.first
      @gift_auction = @game.auctions.gift.first
      @errors = ActiveModel::Errors.new(@character_system)
      default_flaws
      default_wishes
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

  def update
    if gm_user?
      if @character_system.update(title: character_system_params[:title], description: character_system_params[:description])
        redirect_to character_system_path(@character_system)
      else
        @errors = @character_system.errors
        flash[:error] = @errors
        render 'new'
      end
    end
  end

  def destroy
    if gm_user?
      @character_system.destroy
      redirect_to '/'
    else
      redirect_to [@character_system]
    end
  end

  def start
    if gm_user?
      @character_system.started!
      redirect_to [@character_system]
    else
      redirect_to [@character_system]
    end
  end

  def complete
    if gm_user?
      @character_system.completed!
      redirect_to [@character_system]
    else
      redirect_to [@character_system]
    end
  end

  private
    def character_system_params
      params.require(:character_system).permit(:game_id, :title, :description)
    end

    def set_character_system
      @character_system = CharacterSystem.find(params[:id])
    end

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

    def default_wishes
      filename = Rails.root + 'app/assets/files/wishes.utf8.csv'
      CSV.foreach(filename, :headers => true) do |row|
        row_hash = row.to_hash
        wish = Wish.new(character_system: @character_system, name: row_hash['name'], description: row_hash['description'], link: row_hash['link'])
        if wish.save
          # do nothing
        else
          wish.errors.full_messages.each do |msg|
            @errors[:base] << ("Wish error: #{msg}")
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
          @errors[:base] << ("Rank #{item_name} error: #{msg}")
        end
      end
    end
end
