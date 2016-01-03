class CreatePledges < ActiveRecord::Migration
  def change
    create_table :pledges do |t|
      t.integer :rank, default: 0, null: false
      t.belongs_to :character, index: true, foreign_key: true, null: false
      t.belongs_to :char_round, index: true, foreign_key: true, null: false
      t.belongs_to :item, index: true, foreign_key: true, null: false
      t.integer :value, null: false

      t.timestamps null: false
    end
  end
end
