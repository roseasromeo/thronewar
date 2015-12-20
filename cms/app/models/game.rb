class Game < ActiveRecord::Base
  has_many :characters
  has_many :auctions

  enum status: [:preparing, :started, :complete]

  validates_presence_of :title, :status
  validates :title, uniqueness: { case_sensitive: false }
end
