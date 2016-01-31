class CreateContentLinks < ActiveRecord::Migration
  def change
    create_table :content_links do |t|
      t.string :name, null: false
      t.string :link, null: false
      t.integer :order, default: 0, null: false
      t.integer :level, default: 0, null: false

      t.timestamps null: false
    end
  end
end
