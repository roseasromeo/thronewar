class RulesPage < ApplicationRecord
  #has_paper_trail
  before_create :create_slug
  before_update :create_slug
  before_save :create_slug

  has_many :subpages, -> { order(:order_number) }, dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :subpages, reject_if: :subpage_invalid, allow_destroy: true
  validates :title, presence: true, length: { minimum: 5 }, uniqueness: true
  validates_presence_of :name, :slug
  validates :slug, uniqueness: true
  validates :name, uniqueness: true
  validate :subpages_valid

  def to_param
    slug
  end

  private
    def create_slug
      self.slug = self.name.gsub(" ","").gsub("\'","").downcase
    end

    def subpage_invalid(attributes)
      attributes['order_number'] == nil || attributes['subtitle'] == nil
    end

    def subpages_valid
      valid = true
      self.subpages.each do |subpage|
        if subpage.order_number == nil || subpage.subtitle == nil
          valid = false
          errors.add(:subpages, "All subpages must have order number and subtitle.")
        end
      end
      valid
    end

    def find_by_slug(slug)
      RulesPage.where("LOWER(slug) = ?", slug.downcase).first
    end

    def self.search(search)
      RulesPage.all.where("lower(rules_pages.title) LIKE :search OR lower(rules_pages.text) LIKE :search OR lower(subpages.subtitle) LIKE :search OR lower(subpages.sidebar) LIKE :search OR lower(subpages.body) LIKE :search", search: "%#{search.downcase}%").distinct
    end

end
