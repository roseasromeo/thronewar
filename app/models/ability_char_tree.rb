class AbilityCharTree < ApplicationRecord
  belongs_to :char_tree
  belongs_to :ability

  validates_presence_of :char_tree, :ability
end
