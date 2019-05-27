class CharTree < ApplicationRecord
  belongs_to :final_character
  has_many :ability_char_trees
  has_many :abilities, through :ability_char_tree
end
