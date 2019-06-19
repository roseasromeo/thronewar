class CreateCharTrees < ActiveRecord::Migration[5.2]
  def change
    create_table :char_trees do |t|
      t.belongs_to :final_character, foreign_key: true

      t.timestamps
    end
  end
end
