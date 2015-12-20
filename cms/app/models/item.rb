class Item < ActiveRecord::Base
  belongs_to :auction

  enum name: [ :battle, :cunning, :destiny, :ego, :flesh, :command, :change, :illusion, :guttermagic ]

  validates_presence_of :num_strikes, :name, :auction
  validates :closed, :inclusion => { :in => [true, false] }
end
