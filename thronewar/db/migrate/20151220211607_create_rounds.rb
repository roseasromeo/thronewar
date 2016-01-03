class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.belongs_to :auction, index: true, foreign_key: true
      t.integer :number, default: 1

      t.timestamps null: false
    end
  end
end
