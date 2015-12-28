class FinalRank < ActiveRecord::Base
  belongs_to :final_character

  enum item: [ :battle, :cunning, :destiny, :ego, :flesh, :command, :change, :illusion, :gutter_magic ]

  validates_presence_of :character, :item
  validates :half, :inclusion => { :in => [true, false] }
end
