class RemoveLongTextFromAbilities < ActiveRecord::Migration[5.2]
  def change
    remove_column :abilities, :long_text, :string
  end
end
