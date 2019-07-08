class CreatePrompts < ActiveRecord::Migration[5.2]
  def change
    create_table :prompts do |t|
      t.string :name
      t.belongs_to :ability_function, foreign_key: true

      t.timestamps
    end
  end
end
