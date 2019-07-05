class CharactersController < ApplicationController
  def index
    @game = Game.find(params[:game_id])
    @user = current_user
    if gm_user? || @game.complete?
      @new_character = @game.characters.where(user: @user).empty?
      @characters = @game.characters
    else
      redirect_to '/'
    end
  end

  def show
    @game = Game.find(params[:game_id])
    character = Character.find(params[:id])
    if character.user == current_user
      my_character = true
    else
      my_character = false
    end
    if gm_user? || my_character || @game.complete?
      @character = Character.find(params[:id])
      if @game.complete?
        get_auction
        get_current_round
      end
    else
      redirect_to new_game_character_path(@game)
    end
  end

  def new
    if logged_in?
      @user = current_user
      @game = Game.find(params[:game_id])
      if @game.characters.where(user: @user).empty?
        @character = Character.new(game: @game)
      else
        @character = @game.characters.where(user: @user)
        redirect_to game_character_path(@game, @character)
      end
    else
      redirect_to login_path
    end
  end

=begin
  # Currently characters cannot be edited after creation
  def edit
    character = Character.find(params[:id])
    if character.user == current_user
      my_character = true
    else
      my_character = false
    end
    if gm_user? || my_character
      @character = character
    else
      redirect_to new_game_character_path(@game)
    end
  end
=end

  def create
    if logged_in?
      @game = Game.find(params[:game_id])
      @user = current_user
      if @game.characters.where(user: @user).empty?
        @character = Character.new(user: @user, game: @game, pseudonym: character_params[:pseudonym], points_spent: 0)

        if @character.save
          redirect_to game_character_path(@game, @character)
        else
          render 'new'
        end
      else
        @character = @game.characters.where(user: @user)
        redirect_to game_character_path(@game, @character)
      end
    else
      redirect_to login_path
    end
  end

=begin
  # Currently characters cannot be edited
  def update
    character = Character.find(params[:id])
    if character.user == current_user
      my_character = true
    else
      my_character = false
    end
    if gm_user? || my_character
    # THIS WON'T WORK OUT OF THE BOX
      if @character.update(character_page_params, user: )
        redirect_to @character
      else
        render 'edit'
      end
    else
      redirect_to new_game_character_path(@game)
    end
  end
=end

  def destroy
    if gm_user?
      @game = Game.find(params[:game_id])
      @character = Character.find(params[:id])
      @character.destroy

      redirect_to game_characters_path(@game)
    else
      redirect_to '/'
    end
  end

  private
    def character_params
      params.require(:character).permit(:pseudonym, :points_spent)
    end

end
