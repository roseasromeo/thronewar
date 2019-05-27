class AddExtraWishesToFinalCharacter < ActiveRecord::Migration[5.2]
  def change
    add_column :final_characters, :extra_wishes, :integer, default: 0
  end
end
