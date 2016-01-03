class RegencyAbilityValidator < ActiveModel::Validator
  include Rules

  def validate(regency)
    final_character = regency.final_character
    ability_collection = regency_abilities_collection
    valid = true

    keeper = false
    keeper_points = 0
    advanced = 0

    regency.abilities.each do |ability_num|
      if !ability_num.empty?
        if ability_num.to_i >= 5
          advanced = advanced + 1
        end
        if ability_num.to_i == 5
          keeper = true
        end
      end
    end
    if advanced > 1
      valid = false
      regency.errors[:abilities] << "No more than 1 advanced ability may be included."
    end

    # Count Keeper ability points
    if !regency.keeper_abilities.empty?
      regency.keeper_abilities.each do |ability_num|
        if !ability_num.empty?
          keeper_points = keeper_points + get_points(ability_num)
        end
      end
    end
    # If have keeper ability, can have 2 points of abilities for keeper
    # Otherwise, must have 0 points
    if keeper
      if keeper_points > 2
        valid = false
        regency.errors[:keeper_abilities] << "No more than 2 points of abilities can be assigned to a Keeper."
      end
    else
      if keeper_points > 0
        valid = false
        regency.errors[:keeper_abilities] << "Without the Keeper ability, no Keeper abilities should be selected."
      end
    end
    valid
  end

  def get_points(ability)
    if ability == ""
      points = 0
    elsif ability.to_i < 9
      points = 1
    else
      points = 2
    end
  end
end
