class CreateSidebars < ActiveRecord::Migration
  def change
    create_table :sidebars do |t|
      t.text :text
      t.references :subpage, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
