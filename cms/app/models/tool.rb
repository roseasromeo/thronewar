class Tool < ActiveRecord::Base
  belongs_to :final_character

  before_save :set_points

  enum property1: [:no_ability, :rational, :armor, :heroic, :guard, :analytic, :real], _prefix: true
  enum property2: [:no_ability, :rational, :armor, :heroic, :guard, :analytic, :real], _prefix: true
  enum property3: [:no_ability, :rational, :armor, :heroic, :guard, :analytic, :real], _prefix: true
  enum property4: [:no_ability, :rational, :armor, :heroic, :guard, :analytic, :real], _prefix: true
  enum property5: [:no_ability, :rational, :armor, :heroic, :guard, :analytic, :real], _prefix: true
  enum property6: [:no_ability, :rational, :armor, :heroic, :guard, :analytic, :real], _prefix: true

  validates_presence_of :final_character

  def level(property)
    if property == :no_ability
      level = :zero
    elsif property == :rational || property == :armor || property == :heroic
      level = :basic
    elsif property == :guard || property == :analytic
      level = :int
    else
      level = :adv
    end
    level
  end

  def adv_command?(property)
    adv_com = false
    if property == :real
      adv_com = true
    end
    adv_com
  end

  private
    def set_points
      points = 0
      points = points + get_points(level(self.property1))
      points = points + get_points(level(self.property2))
      points = points + get_points(level(self.property3))
      points = points + get_points(level(self.property4))
      points = points + get_points(level(self.property5))
      points = points + get_points(level(self.property6))
    end

    def get_points(level)
      if level == :zero
        points = 0
      elsif level == :basic
        points = 1
      elsif level == :int
        points = 2
      else
        points = 3
      end
    end
end
