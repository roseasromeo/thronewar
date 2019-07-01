class Wish < ApplicationRecord
  belongs_to :character_system
  has_many :final_character_wishes, dependent: :destroy
  has_many :final_characters, through: :final_character_wishes

  validates_presence_of :character_system, :name
end
