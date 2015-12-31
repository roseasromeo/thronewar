class ChangeFlawName < ActiveRecord::Migration
  def change
    remove_foreign_key :final_characters, :flaw1_id
    remove_reference :final_characters, :flaw1_id
    remove_foreign_key :final_characters, :flaw2_id
    remove_reference :final_characters, :flaw2_id
    add_reference :final_characters, :flaw1
    add_foreign_key :final_characters, :flaw1
    add_reference :final_characters, :flaw2
    add_foreign_key :final_characters, :flaw2
  end
end
