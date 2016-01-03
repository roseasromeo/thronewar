class Flaw < ActiveRecord::Base
  belongs_to :character_system
  has_many :final_characters

  validates_presence_of :character_system, :name
end
