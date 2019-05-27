class CreateRanks < ActiveRecord::Migration[5.2]
  def change
    create_table :ranks do |t|
      t.belongs_to :final_character, index: true, foreign_key: true
      t.integer :item, null: false
      t.integer :public_points, default: 0
      t.integer :private_points, default: 0
      t.integer :public_rank, default: 0
      t.integer :private_rank, default: 0
      t.boolean :half, default: false

      t.timestamps null: false
    end
  end
end
