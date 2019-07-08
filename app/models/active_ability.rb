class ActiveAbility < ApplicationRecord
  belongs_to :game_ability
  has_many :prompt_values, dependent: :destroy
  after_commit :create_prompts

  accepts_nested_attributes_for :prompt_values

  private
    def create_prompts

    end

end
