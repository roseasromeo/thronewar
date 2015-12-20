class Character < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  validates_presence_of :pseudonym, :points_spent
  validates_presence_of :user, :game
  validates :pseudonym, uniqueness: { case_sensitive: true }
end
