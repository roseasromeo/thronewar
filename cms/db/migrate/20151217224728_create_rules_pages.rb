class CreateRulesPages < ActiveRecord::Migration
  def change
    create_table :rules_pages do |t|
      t.string :name
      t.string :title
      t.text :text

      t.timestamps null: false
    end
  end
end
