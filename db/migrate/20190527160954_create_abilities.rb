class CreateAbilities < ActiveRecord::Migration[5.2]
  def change
    create_table :abilities do |t|
      t.string :name
      t.string :short_text
      t.string :long_text

      t.timestamps
    end
  end
end
