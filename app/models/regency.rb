class Regency < ApplicationRecord
  belongs_to :final_character

  before_validation :set_points
  validates_with RegencyAbilityValidator
  validates_presence_of :final_character

  private
    def set_points
      points = 0
      self.abilities.each do |ability|
        points = points + get_points(ability)
      end
      self.points = points
    end

    def get_points(ability)
      if ability == ""
        points = 0
      elsif ability.to_i < 3
        points = 1
      elsif ability.to_i < 5
        points = 2
      else
        points = 3
      end
    end


end
