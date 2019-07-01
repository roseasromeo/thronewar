class CreateWishes < ActiveRecord::Migration[5.2]
  def change
    create_table :wishes do |t|
      t.belongs_to :character_system, index: true, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.string :link

      t.timestamps null: false
    end
  end
end
