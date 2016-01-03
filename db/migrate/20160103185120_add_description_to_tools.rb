class AddDescriptionToTools < ActiveRecord::Migration
  def change
    add_column :tools, :description, :text
  end
end
