class CreateStartRanks < ActiveRecord::Migration
  def change
    create_table :start_ranks do |t|
      t.belongs_to :final_character, index: true, foreign_key: true, null: false
      t.integer :item, default: 0, null: false
      t.integer :points, default: 0
      t.integer :rank, default: 0

      t.timestamps null: false
    end
  end
end
