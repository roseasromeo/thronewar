class CreateGameAbilities < ActiveRecord::Migration[5.2]
  def change
    create_table :game_abilities do |t|
      t.string :name
      t.text :long_text
      t.integer :item
      t.string :ability
      t.boolean :targets_another
      t.integer :time_base
      t.string :time_function
      t.integer :rounds_base
      t.string :rounds_function
      t.integer :fate_cost_base
      t.string :fate_cost_function
      t.integer :damage_base
      t.string :damage_function
      t.boolean :secret_action
      t.boolean :cooldown
      t.integer :cooldown_base
      t.string :cooldown_function
      t.boolean :disruptable
      t.integer :disruption_cost_self
      t.integer :disruption_cost_effect
      t.integer :duration_time_base
      t.string :duration_time_function
      t.integer :duration_rounds_base
      t.string :duration_rounds_function
      t.integer :upkeep_cost
      t.string :other_requirements
      t.string :contests
      t.string :edge_function

      t.timestamps
    end
  end
end
