class Ability < ApplicationRecord
  has_many :dependency_links, class_name: "AbilityDependency", foreign_key: "parent_id", dependent: :destroy
  has_many :dependencies, through: :dependency_link, source: :parent

  has_many :dependent_links, class_name: "AbilityDependency", foreign_key: "depends_on_id", dependent: :destroy
  has_many :dependents, through: :dependent_link, source: :depends_on

  accepts_nested_attributes_for :dependency_links, allow_destroy: true

  enum gift: [ :command, :change, :illusion, :gutter_magic ]
  enum level: [ :no, :low, :med, :high ]

  validates_presence_of :gift, :level, :name
end
