class AddLevelToAbilities < ActiveRecord::Migration[5.2]
  def change
    add_column :abilities, :level, :integer, default: 0, null: false
    add_column :abilities, :gift, :integer, default: 0, null: false
  end
end
