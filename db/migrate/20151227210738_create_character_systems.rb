class CreateCharacterSystems < ActiveRecord::Migration[5.2]
  def change
    create_table :character_systems do |t|
      t.belongs_to :game, index: true, foreign_key: true, null: false
      t.string :title, unique: true, null: false
      t.integer :status, default: 0, null: false
      t.text :description

      t.timestamps null: false
    end
  end
end
