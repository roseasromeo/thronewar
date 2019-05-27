class AddAutomaticToAbilities < ActiveRecord::Migration[5.2]
  def change
    add_column :abilities, :automatic, :boolean, default: false, null: false
  end
end
