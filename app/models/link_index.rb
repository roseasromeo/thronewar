class LinkIndex < ActiveRecord::Base
  has_many :content_links

  validates_presence_of :title
  validates_uniqueness_of :title

  accepts_nested_attributes_for :content_links, reject_if: :all_blank, allow_destroy: true
end
