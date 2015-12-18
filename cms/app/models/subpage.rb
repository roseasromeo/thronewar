class Subpage < ActiveRecord::Base
  belongs_to :rules_page
  has_one :sidebar
  has_one :body
end
