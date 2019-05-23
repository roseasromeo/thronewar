class CharacterSystem < ActiveRecord::Base
  belongs_to :game
  has_many :final_characters, dependent: :destroy
  has_many :flaws, dependent: :destroy
  has_many :ranks, through: :final_characters
  has_many :tools, through: :final_characters
  has_many :regencies, through: :final_characters

  enum status: [:preparing, :started, :complete]

  validates_presence_of :status, :title, :game
  validates_uniqueness_of :title
end
