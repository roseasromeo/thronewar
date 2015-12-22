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
      @game = Game.find(params[:id])
      if @game.preparing?
        redirect_to game_path(@game)
      else
        @characters = @game.characters
        @auctions = @game.auctions
        @aspect_auction = @auctions.where(phase: :aspect)
        @aspect_exists = @aspect_auction.empty?
        @gift_auction = @auctions.where(phase: :gift)
        @gift_exists = @gift_auction.empty?
        if @aspect_exists
          @last_aspect_round = @aspect_auction.rounds.order_by(number: :desc).limit(1)
          @last_aspect_pledges = @last_aspect_round.pledges
        else
          @last_aspect_round = nil
          @last_aspect_pledges = nil
        end
        if @gift_exists
          @last_gift_round = @gift_auction.rounds.order_by(number: :desc).limit(1)
          @last_gift_pledges = @last_gift_round.pledges
        else
          @last_gift_round = nil
          @last_gift_pledges = nil
        end

      end
    else
      redirect_to '/'
    end
  end

  def player
    @game = Game.find(params[:id])
    if @game.preparing?
      redirect_to game_path(@game)
    else
      #Display stuff?
    end
  end

  private
    def game_params
      params.require(:game).permit(:title)
    end
end
