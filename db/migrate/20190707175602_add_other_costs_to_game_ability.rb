class AddOtherCostsToGameAbility < ActiveRecord::Migration[5.2]
  def change
    add_column :game_abilities, :other_costs, :string
  end
end
