class CreateFinalCharacters < ActiveRecord::Migration
  def change
    create_table :final_characters do |t|
      t.belongs_to :character_system, index: true, foreign_key: true, null:false
      t.belongs_to :user, index: true, foreign_key: true, null:false
      t.belongs_to :flaw1_id, foreign_key: true
      t.belongs_to :flaw2_id, foreign_key: true
      t.string :name
      t.text :background
      t.text :backstory_connections
      t.text :goal
      t.text :curses
      t.text :standardform
      t.text :other
      t.integer :luck, default: 0
      t.integer :approval, default: 0, null:false
      t.integer :leftover_points, default: 0

      t.timestamps null: false
    end
  end
end
