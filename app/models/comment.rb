class Comment < ApplicationRecord
  belongs_to :rules_page
  belongs_to :user
end
