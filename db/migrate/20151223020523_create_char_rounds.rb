class CreateCharRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :char_rounds do |t|
      t.belongs_to :character, index: true, foreign_key: true, null: false
      t.belongs_to :round, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
