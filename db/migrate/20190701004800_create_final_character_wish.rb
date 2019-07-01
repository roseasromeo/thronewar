class CreateFinalCharacterWish < ActiveRecord::Migration[5.2]
  def change
    create_table :final_character_wishes do |t|
      t.belongs_to :final_character, foreign_key: true
      t.belongs_to :wish, foreign_key: true

      t.timestamps
    end
  end
end
