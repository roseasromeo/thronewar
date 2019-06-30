class RemoveFleshFormsandStandardFormFromFinalCharacter < ActiveRecord::Migration[5.2]
  def change
    remove_column :final_characters, :flesh_forms, :text
    remove_column :final_characters, :standard_form, :text
  end
end
