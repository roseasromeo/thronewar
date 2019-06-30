class CreatureFormsController < ApplicationController
  before_action :set_creature_form, only: [:show, :edit, :update, :destroy]
  include Rules
  #helper_method :font?, :perk_category, :perk_sort

  # def index
  #   @character_system = CharacterSystem.find(params[:character_system_id])
  #
  #   if gm_user? || @character_system.complete?
  #     @forms = @character_system.creature_forms
  #   else
  #     redirect_to [@character_system]
  #   end
  # end

  def show
    @user = current_user
    @final_character = @form.final_character
    @character_system = @final_character.character_system
    @show_all = false
    @show_standard = false
    @dual_existence = dual_existence?(@final_character)

    if gm_user? || @final_character.user == @user || @character_system.complete?
      @show_all = true
    elsif @form.standard_form?
      @show_standard = true
    else
      redirect_to [@character_system]
    end
  end

  def new
    @user = current_user
    @final_character = FinalCharacter.find(params[:final_character])
    @character_system = CharacterSystem.find(params[:character_system_id])
    @perk_collection = perks
    @dual_existence = dual_existence?(@final_character)

    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      @form = CreatureForm.new
    else
      redirect_to [@character_system]
    end
  end

  def edit
    @user = current_user
    @final_character = @form.final_character
    @character_system = CharacterSystem.find(params[:character_system_id])
    @perk_collection = perks
    @dual_existence = dual_existence?(@final_character)

    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      # edit
    else
      redirect_to [@character_system]
    end
  end

  def create
    @user = current_user
    @final_character = FinalCharacter.find(creature_form_params[:final_character])
    @character_system = CharacterSystem.find(params[:character_system_id])
    @perk_collection = perks
    @dual_existence = dual_existence?(@final_character)

    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      @form = CreatureForm.new(final_character: @final_character, name: creature_form_params[:name], description: creature_form_params[:description], standard_form: creature_form_params[:standard_form], perk: creature_form_params[:perk], extra_environment: creature_form_params[:extra_environment])
      if @form.save
        @final_character.save
        redirect_to [@character_system, @form]
      else
        render 'new'
      end
    else
      redirect_to @character_system
    end
  end

  def update
    @user = current_user
    @final_character = FinalCharacter.find(creature_form_params[:final_character])
    @character_system = CharacterSystem.find(params[:character_system_id])
    @perk_collection = perks
    @dual_existence = dual_existence?(@final_character)

    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      if @form.update(final_character: @final_character, name: creature_form_params[:name], description: creature_form_params[:description], standard_form: creature_form_params[:standard_form], perk: creature_form_params[:perk], extra_environment: creature_form_params[:extra_environment])
        @final_character.save
        redirect_to [@character_system, @form]
      else
        render 'edit'
      end
    else
      redirect_to [@character_system]
    end
  end

  def destroy
    @user = current_user
    @final_character = FinalCharacter.find(creature_form_params[:final_character])
    @character_system = CharacterSystem.find(params[:character_system_id])

    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      @form.destroy
      redirect_to [@character_system]
    else
      redirect_to [@character_system]
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_creature_form
      @form = CreatureForm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def creature_form_params
      params.require(:creature_form).permit(:final_character, :name, :description, :perk, :extra_environment, :standard_form)
    end
end
