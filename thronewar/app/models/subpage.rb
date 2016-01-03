class Subpage < ActiveRecord::Base
  has_paper_trail

  belongs_to :rules_page
  validates_presence_of :subtitle, :order_number
end
