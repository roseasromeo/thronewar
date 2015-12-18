class CreateSubpages < ActiveRecord::Migration
  def change
    create_table :subpages do |t|
      t.string :subtitle
      t.references :rules_page, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
