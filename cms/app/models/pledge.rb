class Pledge < ActiveRecord::Base
  belongs_to :character
  belongs_to :round
  belongs_to :item

  validates_presence_of :rank, :value
  validates_presence_of :character, :round, :item
end
