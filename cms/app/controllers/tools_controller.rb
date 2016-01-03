class ToolsController < ApplicationController
  include Rules

  def index
    @character_system = CharacterSystem.find(params[:character_system_id])

    if gm_user? || @character_system.complete?
      @tools = @character_system.tools
    else
      redirect_to [@character_system]
    end
  end

  def show
    @user = current_user
    @tool = Tool.find(params[:id])
    @final_character = @tool.final_character
    @character_system = @final_character.character_system
    @ability_collection = tool_abilities_collection(@final_character, true)
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
    @character_system = CharacterSystem.find(params[:character_system_id])
    @ability_collection = tool_abilities_collection(@final_character, false)

    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      @tool = Tool.new
    else
      redirect_to [@character_system]
    end
  end

  def edit
    @user = current_user
    @tool = Tool.find(params[:id])
    @final_character = @tool.final_character
    @character_system = CharacterSystem.find(params[:character_system_id])
    @ability_collection = tool_abilities_collection(@final_character, false)

    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      # edit
    else
      redirect_to [@character_system]
    end
  end

  def create
    @user = current_user
    @final_character = FinalCharacter.find(tool_params[:final_character])
    @character_system = CharacterSystem.find(params[:character_system_id])
    @ability_collection = tool_abilities_collection(@final_character, false)

    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      @tool = Tool.new(name: tool_params[:name], final_character: @final_character, abilities: tool_params[:abilities])
      if @tool.save
        @final_character.save
        redirect_to [@character_system, @tool]
      else
        render 'new'
      end
    else
      redirect_to @character_system
    end
  end

  def update
    @user = current_user
    @tool = Tool.find(params[:id])
    @final_character = FinalCharacter.find(tool_params[:final_character])
    @character_system = CharacterSystem.find(params[:character_system_id])
    @ability_collection = tool_abilities_collection(@final_character, false)

    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      if @tool.update(name: tool_params[:name], final_character: @final_character, abilities: tool_params[:abilities])
        @final_character.save
        redirect_to [@character_system, @tool]
      else
        render 'edit'
      end
    else
      redirect_to [@character_system]
    end
  end

  def destroy
    @user = current_user
    @tool = Tool.find(params[:id])
    @final_character = FinalCharacter.find(tool_params[:final_character_id])
    @character_system = CharacterSystem.find(params[:character_system_id])

    if gm_user? || (@final_character.user == @user && @final_character.not_submitted?)
      @tool.destroy
      redirect_to [@character_system]
    else
      redirect_to [@character_system]
    end
  end

  private
    def tool_params
      params.require(:tool).permit(:final_character, :name, :abilities => [])
    end

end
