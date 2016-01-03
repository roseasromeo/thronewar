class ToolAbilityValidator < ActiveModel::Validator
  include Rules

  def validate(tool)
    final_character = tool.final_character
    ability_collection = tool_abilities_collection(final_character,false)
    valid = true
    collar = false
    advanced = 0
    ability_count = 0
    wisp = false
    tool.abilities.each do |ability_num|
      error = true
      if !ability_num.empty?
        ability_collection.each do |ability_key|
          if ability_key[1] == ability_num.to_i
            error = false
            ability_count = ability_count + 1
          end
        end
        if ability_num.to_i >= 20
          advanced = advanced + 1
        end
        if ability_num.to_i == collar_num
          collar = true
        elsif ability_num.to_i == wisp_num
          wisp = true
        end
      else
        error = false
      end
      if error
        tool.abilities.delete(ability_num)
        valid = false
        tool.errors[:abilities] << "An ability invalid for this character was included and has now been deleted."
      end
    end
    if advanced > 1
      valid = false
      tool.errors[:abilities] << "No more than 1 advanced ability may be included."
    end
    if collar && advanced > 0
      valid = false
      tool.errors[:abilities] << "No advanced abilities may be included with the Collar ability."
    end
    if wisp && ability_count > 1
      valid = false
      tool.errors[:abilities] << "No other abilities may be included with the Wisp ability."
    end
    if ability_count > 3
      valid = false
      tool.errors[:abilities] << "Tools have a maximum of three abilities."
    end
    if tool.points > 6
      valid = false
      tool.errors[:abilities] << "Tool points may not exceed 6 points."
    end
    valid
  end
end
