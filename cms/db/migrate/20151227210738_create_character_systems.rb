class CreateCharacterSystems < ActiveRecord::Migration
  def change
    create_table :character_systems do |t|
      t.string :title, unique: true, null: false
      t.integer :status, default: 0, null: false
      t.text :description

      t.timestamps null: false
    end
  end
end
