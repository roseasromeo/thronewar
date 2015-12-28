class AddBlurbToFinalCharacters < ActiveRecord::Migration
  def change
    add_column :final_characters, :blurb, :text
  end
end
