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
      redirect_to character_system_final_character_path(@character_system, @final_character)
    end
  end

  def update
    @user = current_user
    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      @character_system = CharacterSystem.find(params[:character_system_id])
      @user = User.find(final_character_params[:user_id])
      leftover_points = 0
      @final_character = FinalCharacter.new(character_system: @character_system, user: @user, name: final_character_params[:name], blurb: final_character_params[:blurb], background: final_character_params[:background], backstory_connections: final_character_params[:backstory_connections], goal: final_character_params[:goal], curses: final_character_params[:curses], standardform: final_character_params[:standardform], other: final_character_params[:other], luck: final_character_params[:luck], leftover_points: leftover_points)

      if @final_character.save
        redirect_to [@character_system, @final_character]
      else
        render 'edit'
      end
    else
      redirect_to character_system_final_character_path(@character_system, @final_character)
    end
  end

  helper_method :html_safe_rescue, :rank_collection

  private
    def final_character_params
      params.require(:final_character).permit(:user_id, :flaw1_id, :flaw2_id, :name, :blurb, :background, :backstory_connections, :goal, :curses, :standardform, :other, :luck, :leftover_points)
      #  final_rank_attributes: [:id, :_destroy])
    end

    def html_safe_rescue(text)
      text_return = text.html_safe
    rescue NoMethodError
      text_return = ""
    end

    def rank_collection(item, final_character)
      [final_character.start_ranks.where(item: item).first.rank]
    end
end
