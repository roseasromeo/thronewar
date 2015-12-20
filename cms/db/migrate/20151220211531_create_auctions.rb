class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.belongs_to :game, index: true, foreign_key: true

      t.integer :phase, default: 0, null: false

      t.boolean :closed, default: false

      t.timestamps null: false
    end
  end
end
