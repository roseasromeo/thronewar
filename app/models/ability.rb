class Ability < ApplicationRecord
  has_many :dependency_links, class_name: "AbilityDependency", foreign_key: "parent_id", dependent: :destroy
  has_many :dependencies, through: :dependency_links, source: :depends_on

  has_many :dependent_links, class_name: "AbilityDependency", foreign_key: "depends_on_id", dependent: :destroy
  has_many :dependents, through: :dependent_links, source: :parent_id

  accepts_nested_attributes_for :dependency_links, allow_destroy: true

  enum gift: [ :command, :change, :illusion, :gutter_magic ]
  enum level: [ :no, :basic, :intermediate, :advanced ]

  validates_presence_of :gift, :level, :name

  def label
    if self.automatic?
      automatic = " Automatic "
    else
      automatic = ''
    end

    depends_on = ''
    if !(self.dependencies.empty?)
      depends_on = ' Depends on:'
      self.dependencies.each do |dependency|
        depends_on = depends_on + ' *' + dependency.name
      end
    end

    label = self.name + " " + self.gift.titlecase + " " + self.level.titlecase + automatic + depends_on
    label
  end

end
