class CreateRegencies < ActiveRecord::Migration
  def change
    create_table :regencies do |t|
      t.belongs_to :final_character, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.text :abilities, array: true, default: []

      t.timestamps null: false
    end
  end
end
