class Round < ActiveRecord::Base
  belongs_to :auction
  has_many :char_rounds
  has_many :pledges, through: :char_rounds
  has_many :characters, through: :pledges
  has_many :items, through: :pledges

  validates_presence_of :number, :auction
end
