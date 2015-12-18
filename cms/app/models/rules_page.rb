class RulesPage < ActiveRecord::Base
  has_paper_trail

  has_many :subpages
  accepts_nested_attributes_for :subpages, reject_if: :all_blank, allow_destroy: true
  validates :title, presence: true, length: { minimum: 5 }, uniqueness: true
end
