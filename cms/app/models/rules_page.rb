class RulesPage < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 5 }, uniqueness: true
end
