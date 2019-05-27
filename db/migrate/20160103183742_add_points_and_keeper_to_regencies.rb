class AddPointsAndKeeperToRegencies < ActiveRecord::Migration[5.2]
  def change
    add_column :regencies, :points, :integer, default: 0
    add_column :regencies, :keeper_abilities, :text, array: true, default: []
  end
end
