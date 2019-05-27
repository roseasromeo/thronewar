class CreateTools < ActiveRecord::Migration[5.2]
  def change
    create_table :tools do |t|
      t.belongs_to :final_character, index: true, foreign_key: true, null: false
      t.string :name
      t.integer :points, default: 0
      t.text :abilities, array: true, default: []

      t.timestamps null: false
    end
  end
end
