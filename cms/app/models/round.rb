class Round < ActiveRecord::Base
  belongs_to :auction
  has_many :pledges
  has_many :characters, through: :pledges
  has_many :items, through: :pledges

  validates_presence_of :number, :auction
end
