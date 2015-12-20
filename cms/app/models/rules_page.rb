class RulesPage < ActiveRecord::Base
  has_paper_trail
  before_create :create_slug
  before_update :create_slug

  has_many :subpages, -> { order(:order_number) }
  has_many :comments
  accepts_nested_attributes_for :subpages, reject_if: :all_blank, allow_destroy: true
  validates :title, presence: true, length: { minimum: 5 }, uniqueness: true
  validates_presence_of :name, :slug
  validates :slug, uniqueness: true

  def to_param
    slug
  end

  def create_slug
    self.slug = self.name.gsub(" ","")
  end
end
