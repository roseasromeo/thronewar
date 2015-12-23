class CharRound < ActiveRecord::Base
  belongs_to :character
  belongs_to :round
  has_many :pledges

  validates_presence_of :character, :round
end
