class CreatureForm < ApplicationRecord
  belongs_to :final_character
  include Rules

  before_validation :set_environment
  validates_presence_of :name, :final_character
  validates_with CreatureFormValidator

  enum environment: [ :standard, :aquatic ]
  enum extra_environment: [ :standard_extra, :aquatic_extra, :volcanic, :glacial, :vacuum ]

  def perk_name
    perks_list = perks
    name = ''
    perks.each do |perk|
      if perk[1] == self.perk
        name = perk[0]
      end
    end
    name
  end

  private
    def set_environment
      environment = :standard
      if self.standard_form?
        environment = :standard
      elsif standard_perk?(self.perk)
        environment = :standard
      elsif aquatic_perk?(self.perk)
        environment = :aquatic
      else
        environment = :standard
      end
      self.environment = environment
    end


end
