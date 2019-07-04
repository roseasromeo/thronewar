class GameAbility < ApplicationRecord
  #has_many :edge_generators

  enum item: [ :battle, :cunning, :destiny, :ego, :flesh, :command, :change, :illusion, :gutter_magic ]

  validates_presence_of :name, :item
end
