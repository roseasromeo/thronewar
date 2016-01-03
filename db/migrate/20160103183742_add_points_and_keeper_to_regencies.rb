class AddPointsAndKeeperToRegencies < ActiveRecord::Migration
  def change
    add_column :regencies, :points, :integer, default: 0
    add_column :regencies, :keeper_abilities, :text, array: true, default: []
  end
end
