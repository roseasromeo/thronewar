class RemoveWishesFromFinalCharacter < ActiveRecord::Migration[5.2]
  def change
    remove_column :final_characters, :wishes, :text
  end
end
