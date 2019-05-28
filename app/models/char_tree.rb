class CharTree < ApplicationRecord
  include Rules

  belongs_to :final_character
  has_many :ability_char_trees
  has_many :abilities, through: :ability_char_trees

  accepts_nested_attributes_for :ability_char_trees, allow_destroy: true

  validates_with AbilityCharTreeValidator
  validates_presence_of :final_character

  def ability_collection(all_abilities)
    gift_abilities_collection(self.final_character,all_abilities,Ability.all)
  end

end
