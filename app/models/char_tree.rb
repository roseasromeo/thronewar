class CharTree < ApplicationRecord
  include Rules

  belongs_to :final_character
  has_many :ability_char_trees, dependent: :destroy
  has_many :abilities, through: :ability_char_trees

  accepts_nested_attributes_for :ability_char_trees, allow_destroy: true

  validates_with CharTreeValidator
  validates_presence_of :final_character

  def abilities_collection(all_abilities)
    collection = []
    abilities = gift_abilities_collection(self.final_character,all_abilities,Ability.all)
    abilities.each do |ability|
      collection << [ability.label, ability.id]
    end
    collection
  end

  def abilities_all(all_abilities)
    abilities_all = gift_abilities_collection(self.final_character,all_abilities,Ability.all)
    abilities_all
  end

  def ability_char_tree_cleanup
    cleanup = false
    abilities_collection = self.abilities_all(false)
    abilities = self.abilities
    abilities.each do |ability|
      if abilities_collection.where(id: ability.id).empty?
        self.ability_char_trees.where(ability_id: ability.id).each do |ability_char_tree|
          ability_char_tree.destroy
          cleanup = true
        end
      end
    end
    cleanup
  end

end
