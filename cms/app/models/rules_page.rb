class RulesPage < ActiveRecord::Base
  has_paper_trail

  has_many :subpages
  validates :title, presence: true, length: { minimum: 5 }, uniqueness: true
end
