class AbilityDependency < ApplicationRecord
  belongs_to :parent, class_name: 'Ability', foreign_key: 'parent_id'
  belongs_to :depends_on, class_name: 'Ability', foreign_key: 'depends_on_id'

  validates_presence_of :depends_on
end
