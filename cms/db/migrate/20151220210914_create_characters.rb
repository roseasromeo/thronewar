class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :pseudonym, unique: true, null: false

      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :game, index: true, foreign_key: true

      t.integer :points_spent, default: 0, null: false

      t.timestamps null: false
    end
  end
end
