class AbilityDependency < ApplicationRecord
  belongs_to :parent, :class_name => "ability", :foreign_key => "parent_id"
  belongs_to :depends_on, :class_name => "ability", :foreign_key => "depends_on_id"
end
