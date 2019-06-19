class AddParentToAbilityDependencies < ActiveRecord::Migration[5.2]
  def change
    add_reference :ability_dependencies, :parent, index: true   # foreign_key: true <= remove this!
    add_reference :ability_dependencies, :depends_on, index: true
    add_foreign_key :ability_dependencies, :abilities, column: :parent_id
    add_foreign_key :ability_dependencies, :abilities, column: :depends_on_id
  end
end
