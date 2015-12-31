class Tool < ActiveRecord::Base
  belongs_to :final_character

  validates_presence_of :final_character
end
