class ToolsController < ApplicationController
  include Rules
  helper_method :font?, :ability_category, :ability_sort

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
      @tool_categories = ability_categories(@tool.abilities)
    else
      redirect_to [@character_system]
    end
  end

  def new
    @user = current_user
    @final_character = FinalCharacter.find(params[:final_character])
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
      @tool = Tool.new(name: tool_params[:name], final_character: @final_character, description: tool_params[:description], abilities: tool_params[:abilities])
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
      if @tool.update(name: tool_params[:name], final_character: @final_character, description: tool_params[:description], abilities: tool_params[:abilities])
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
    @final_character = FinalCharacter.find(tool_params[:final_character])
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
      params.require(:tool).permit(:final_character, :name, :description, :abilities => [])
    end

    def ability_categories(abilities)
      categories = [false, false, false, false]
      abilities.each do |ability|
        i = 0
        ab_cat = ability_category(ability)
        categories.each do |category|
          categories[i] = (category || ab_cat[i])
          i = i + 1
        end
      end
      categories
    end

    def ability_category(ability)
      categories = [false, false, false, false]
      command_keys = [0, 1, 2, 12, 13, 20]
      change_keys = [3, 4, 5, 14, 15, 21]
      illusion_keys = [6, 7, 8, 16, 17, 22]
      gutter_magic_keys = [9, 10, 11, 18, 19]
      if !ability.empty?
        ability_key = ability.to_i
        command_keys.each do |key|
          if ability_key == key
            categories[0] = true
          end
        end
        change_keys.each do |key|
          if ability_key == key
            categories[1] = true
          end
        end
        illusion_keys.each do |key|
          if ability_key == key
            categories[2] = true
          end
        end
        gutter_magic_keys.each do |key|
          if ability_key == key
            categories[3] = true
          end
        end
      end
      categories
    end

    def ability_sort(ability)
      if !ability.empty?
        value1 = (ability_category(ability)[0] ? 0 : 1)*100000
        value2 = (ability_category(ability)[1] ? 0 : 1)*10000
        value3 = (ability_category(ability)[2] ? 0 : 1)*1000
        value4 = (ability_category(ability)[3] ? 0 : 1)*100
        value5 = ability.to_i
        return_value = value1 + value2 + value3 + value4 + value5
      else
        return_value = 0
      end
      return_value
    end
end
