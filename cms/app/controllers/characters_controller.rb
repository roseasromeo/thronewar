class CharactersController < ApplicationController
  def index
    if admin_user?
      @characters = Character.all
    else
      redirect_to '/'
    end
  end

  def show
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
      @character = Character.new
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
      @character = Character.new(character_params)

      if @character.save
        redirect_to @character
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
      if @rules_page.update(rules_page_params)
        redirect_to @rules_page
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
      params.require(:character).permit(:user, :game, :pseudonym, :points_spent)
    end

end
