class CreatePromptValues < ActiveRecord::Migration[5.2]
  def change
    create_table :prompt_values do |t|
      t.belongs_to :prompt, foreign_key: true
      t.belongs_to :active_ability, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
