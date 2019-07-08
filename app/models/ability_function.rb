class AbilityFunction < ApplicationRecord
  has_many :prompts
  has_many :prompt_values, through: :prompts

  validates_presence_of :name

end
