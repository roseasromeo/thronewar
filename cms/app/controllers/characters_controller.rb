class CharactersController < ApplicationController
  def index
    if gm_user?
      @game = Game.find(params[:game_id])
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
    if gm_user? || my_character
      @character = Character.find(params[:id])
    else
      redirect_to new_character_path
    end
  end

  def new
    if logged_in?
      @game = Game.find(params[:game_id])
      @character = Character.new(game: @game)
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
      redirect_to new_character_path
    end
  end
=end

  def create
    if logged_in?
      @game = Game.find(params[:game_id])
      @user = current_user
      @character = Character.new(user: @user, game: @game, pseudonym: character_params[:pseudonym], points_spent: 0)

      if @character.save
        redirect_to game_character_path(@game, @character)
      else
        render 'new'
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
      redirect_to new_character_path
    end
  end
=end

  def destroy
    if logged_in?
      if gm_user?
        @character = Character.find(params[:id])
        @character.destroy

        redirect_to characters_path
      else
        redirect_to '/'
      end
    else
      redirect_to login_path
    end
  end

  private
    def character_params
      params.require(:character).permit(:pseudonym, :points_spent)
    end

end
