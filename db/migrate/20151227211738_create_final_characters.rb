class CreateFinalCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :final_characters do |t|
      t.belongs_to :character_system, index: true, foreign_key: true, null:false
      t.belongs_to :user, index: true, foreign_key: true, null:false
      t.integer :flaw1
      t.integer :flaw2
      t.string :name
      t.text :blurb
      t.text :background
      t.text :backstory_connections
      t.text :goal
      t.text :curses
      t.text :standard_form
      t.text :wishes
      t.text :flesh_forms
      t.text :other
      t.integer :luck, default: 0
      t.integer :approval, default: 0, null:false
      t.integer :leftover_points, default: 0

      t.timestamps null: false
    end
    add_foreign_key :final_characters, :flaws, column: :flaw1
    add_foreign_key :final_characters, :flaws, column: :flaw2
  end
end
