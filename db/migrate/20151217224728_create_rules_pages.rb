class CreateRulesPages < ActiveRecord::Migration[5.2]
  def change
    create_table :rules_pages do |t|
      t.string :name, unique: true
      t.string :slug, :default => "1"
      t.string :title, unique: true
      t.text :text

      t.timestamps null: false
    end
  end
end
