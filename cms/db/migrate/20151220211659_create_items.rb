class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.boolean :closed, default: false
      t.integer :num_strikes, default: 0
      t.integer :name, default: 0, null: false
      t.belongs_to :auction, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
