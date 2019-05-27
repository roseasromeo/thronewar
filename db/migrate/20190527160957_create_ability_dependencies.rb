class CreateAbilityDependencies < ActiveRecord::Migration[5.2]
  def change
    create_table :ability_dependencies do |t|
      t.timestamps
    end
  end
end
