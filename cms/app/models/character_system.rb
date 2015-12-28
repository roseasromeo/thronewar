class CharacterSystem < ActiveRecord::Base
  belongs_to :game
  has_many :final_characters, dependent: :destroy
  has_many :flaws, dependent: :destroy

  enum status: [:preparing, :started, :complete]

  validates_presence_of :status, :title, :game
  validates_uniqueness_of :title
end
