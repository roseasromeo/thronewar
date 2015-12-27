class CharacterSystem < ActiveRecord::Base
  has_many :final_characters
  has_many :flaws
  
  enum status: [:preparing, :started, :complete]

  validates
end
