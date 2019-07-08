class CreateActiveAbilities < ActiveRecord::Migration[5.2]
  def change
    create_table :active_abilities do |t|
      t.belongs_to :game_ability, foreign_key: true
      t.integer :rounds_total

      t.timestamps
    end
  end
end
