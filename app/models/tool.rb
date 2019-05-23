class Tool < ActiveRecord::Base
  include Rules
  belongs_to :final_character

  before_validation :set_points
  validates_with ToolAbilityValidator
  validates_presence_of :final_character

  private
    def set_points
      points = 0
      improved_wisp = false
      self.abilities.each do |ability|
        points = points + get_points(ability)
        if ability == improved_wisp_num
          improved_wisp = true
        end
      end
      if improved_wisp && points > 3
        #improved wisp discount
        points = points - 1
      end
      self.points = points
    end

    def get_points(ability)
      if ability == ""
        points = 0
      elsif ability.to_i < 12
        points = 1
      elsif ability.to_i < 20
        points = 2
      else
        points = 3
      end
    end


end
