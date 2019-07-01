class AddLongTextToAbilities < ActiveRecord::Migration[5.2]
  def change
    add_column :abilities, :long_text, :text
  end
end
