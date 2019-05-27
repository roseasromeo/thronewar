class CreateLinkIndices < ActiveRecord::Migration[5.2]
  def change
    create_table :link_indices do |t|
      t.string :title, null: false, unique: true
      t.timestamps null: false
    end
  end
end
