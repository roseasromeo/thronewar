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
      @game = Game.find(params[:id])
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

  private
    def game_params
      params.require(:game).permit(:title)
    end
end
