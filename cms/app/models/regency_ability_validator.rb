class RegencyAbilityValidator < ActiveModel::Validator
  include Rules

  def validate(regency)
    final_character = regency.final_character
    ability_collection = regency_abilities_collection
    valid = true
    advanced = 0
    regency.abilities.each do |ability_num|
      if !ability_num.empty?
        if ability_num.to_i >= 5
          advanced = advanced + 1
        end
      end
    end
    if advanced > 1
      valid = false
      regency.errors[:abilities] << "No more than 1 advanced ability may be included."
    end
    valid
  end
end
