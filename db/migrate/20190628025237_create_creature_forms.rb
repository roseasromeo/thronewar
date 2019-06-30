class CreateCreatureForms < ActiveRecord::Migration[5.2]
  def change
    create_table :creature_forms do |t|
      t.belongs_to :final_character, foreign_key: true
      t.string :name
      t.string :description
      t.integer :perk, default: 0
      t.integer :environment, default: 0
      t.integer :extra_environment, default: 0
      t.boolean :standard_form, default: false

      t.timestamps
    end
  end
end
