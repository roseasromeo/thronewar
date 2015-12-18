class RulesPage < ActiveRecord::Base
  has_paper_trail
  
  validates :title, presence: true, length: { minimum: 5 }, uniqueness: true
end
