class Comment < ActiveRecord::Base
  belongs_to :rules_page
  belongs_to :user
end
