class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.text :body
      t.belongs_to :rules_page, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
