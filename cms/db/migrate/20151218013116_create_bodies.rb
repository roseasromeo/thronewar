class CreateBodies < ActiveRecord::Migration
  def change
    create_table :bodies do |t|
      t.text :text
      t.references :subpage, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
