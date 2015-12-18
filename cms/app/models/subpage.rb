class Subpage < ActiveRecord::Base
  has_paper_trail

  belongs_to :rules_page
end
