class RegenciesController < ApplicationController
  def index
    @character_system = CharacterSystem.find(params[:character_system_id])
    if gm_user?
      @regencies = @character_system.regencies
    else
      redirect_to [@character_system]
    end
  end

  def show
    @user = current_user
    @regency = Regency.find(params[:id])
    @final_character = @regency.final_character
    @character_system = @final_character.character_system
    @show_all = false
    if gm_user? || @final_character.user == @user || @character_system.complete?
      @show_all = true
    else
      redirect_to [@character_system]
    end
  end

  def new
    @user = current_user
    @final_character = FinalCharacter.find(params[:final_character_id])
    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      @regency = Regency.new
    else
      redirect_to [@character_system]
    end
  end

  def edit
    @user = current_user
    @regency = Regency.find(params[:id])
    @final_character = @regency.final_character
    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      # edit
    else
      redirect_to [@character_system]
    end
  end

  def create
    @user = current_user
    @final_character = FinalCharacter.find(regency_params[:final_character_id])
    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      @regency.new(regency_params)
      if @regency.save
        redirect_to [@character_system, @regency]
      else
        render 'new'
      end
    else
      redirect_to @character_system
    end
  end

  def update
    @user = current_user
    @regency = Regency.find(params[:id])
    @final_character = FinalCharacter.find(regency_params[:final_character_id])
    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      if @regency.update(regency_params)
        redirect_to [@character_system, @regency]
      else
        render 'edit'
      end
    else
      redirect_to [@character_system]
    end
  end

  def destroy
    @user = current_user
    @regency = Regency.find(params[:id])
    @final_character = FinalCharacter.find(regency_params[:final_character_id])
    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      @regency.destroy
      redirect_to [@character_system]
    else
      redirect_to [@character_system]
    end
  end

  private
    def regency_params
      params.require(:regency).permit(:final_character_id)
    end
end
