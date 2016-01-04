class RulesPage < ActiveRecord::Base
  has_paper_trail
  before_create :create_slug
  before_update :create_slug

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
      self.slug = self.name.gsub(" ","").gsub("\'","")
    end

    def subpage_invalid(attributes)
      attributes['order_number'] == nil || attributes['subtitle'] == nil
    end

    def subpages_valid
      valid = true
      puts "We're validating"
      self.subpages.each do |subpage|
        if subpage.order_number == nil || subpage.subtitle == nil
          valid = false
          puts "something's not right"
          errors.add(:subpages, "All subpages must have order number and subtitle.")
        end
      end
      valid
    end
end
