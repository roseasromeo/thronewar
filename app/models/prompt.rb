class Prompt < ApplicationRecord
  belongs_to :ability_function

  validates_presence_of :name
end
