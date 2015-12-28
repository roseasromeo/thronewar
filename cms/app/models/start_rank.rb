class StartRank < ActiveRecord::Base
  belongs_to :final_character

  enum item: [ :battle, :cunning, :destiny, :ego, :flesh, :command, :change, :illusion, :gutter_magic ]

  validates_presence_of :final_character, :item
end
