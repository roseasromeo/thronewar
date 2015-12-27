class CreateFlaws < ActiveRecord::Migration
  def change
    create_table :flaws do |t|
      t.belongs_to :character_system, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.string :link

      t.timestamps null: false
    end
  end
end
