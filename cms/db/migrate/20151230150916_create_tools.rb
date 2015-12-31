class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.belongs_to :final_character, index: true, foreign_key: true, null: false
      t.string :name
      t.integer :points, default: 0
      t.integer :property1, default: 0
      t.integer :property2, default: 0
      t.integer :property3, default: 0
      t.integer :property4, default: 0
      t.integer :property5, default: 0
      t.integer :property6, default: 0

      t.timestamps null: false
    end
  end
end
