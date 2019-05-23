class Game < ActiveRecord::Base
  has_many :characters, dependent: :destroy
  has_many :auctions, dependent: :destroy
  has_one :character_system, dependent: :destroy

  enum status: [:preparing, :started, :complete]

  validates_presence_of :title, :status
  validates :title, uniqueness: { case_sensitive: false }
end
