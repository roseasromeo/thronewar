class Item < ApplicationRecord
  belongs_to :auction

  enum name: [ :battle, :cunning, :destiny, :ego, :flesh, :command, :change, :illusion, :gutter_magic ]

  validates_presence_of :num_strikes, :name, :auction
  validates :closed, :inclusion => { :in => [true, false] }
end
