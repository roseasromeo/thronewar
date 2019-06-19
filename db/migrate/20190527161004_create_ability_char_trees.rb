class CreateAbilityCharTrees < ActiveRecord::Migration[5.2]
  def change
    create_table :ability_char_trees do |t|
      t.belongs_to :char_tree, foreign_key: true
      t.belongs_to :ability, foreign_key: true

      t.timestamps
    end
  end
end
