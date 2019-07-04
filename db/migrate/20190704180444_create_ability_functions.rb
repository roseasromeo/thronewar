class CreateAbilityFunctions < ActiveRecord::Migration[5.2]
  def change
    create_table :ability_functions do |t|
      t.string :name
      t.string :operation

      t.timestamps
    end
  end
end
