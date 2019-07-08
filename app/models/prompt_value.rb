class PromptValue < ApplicationRecord
  belongs_to :prompt
  belongs_to :active_ability
end
