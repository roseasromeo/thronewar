class Auction < ActiveRecord::Base
  belongs_to :game
  has_many :items
  has_many :rounds
  has_many :pledges, through: :rounds
  has_many :characters, through: :game

  enum phase: [:aspect, :gift]

  validates_presence_of :phase
  validates_presence_of :game
end