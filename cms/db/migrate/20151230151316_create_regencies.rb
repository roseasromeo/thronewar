class CreateRegencies < ActiveRecord::Migration
  def change
    create_table :regencies do |t|
      t.belongs_to :final_character, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.integer :points, default: 0
      t.integer :basic_property1, default: 0
      t.integer :basic_property2, default: 0
      t.integer :basic_property3, default: 0
      t.integer :intermediate_property1, default: 0
      t.integer :intermediate_property2, default: 0
      t.integer :advanced_property, default: 0

      t.timestamps null: false
    end
  end
end
