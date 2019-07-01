class FinalCharacterWish < ApplicationRecord
  belongs_to :final_character
  belongs_to :wish

  validates_presence_of :final_character, :wish
end
