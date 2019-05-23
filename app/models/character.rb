class Character < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_many :char_rounds, dependent: :destroy
  has_many :pledges, through: :char_rounds

  validates_presence_of :pseudonym, :points_spent
  validates_presence_of :user, :game
  validates :pseudonym, uniqueness: { case_sensitive: true }
end
