class FinalCharactersController < ApplicationController
  def show
    @final_character = FinalCharacter.find(params[:id])
    @user = current_user
    @character_system = @final_character.character_system
    if gm_user? || @final_character.user == @user || @character_system.complete?
      @show_all = true
    else
      @show_all = false
    end
  end

  def edit
    @final_character = FinalCharacter.find(params[:id])
    @user = current_user
    @character_system = @final_character.character_system
    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      # edit
    else
      redirect_to final_character_path(@final_character)
    end
  end

  def update

  end
end
