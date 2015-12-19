class User < ActiveRecord::Base
  validates :email, :name, :password_digest, :user_type, presence: true
  validates :email, :name, uniqueness: { case_sensitive: false }

  before_save { |user| user.email = email.downcase }

  has_secure_password

  # user types
  # 0 = website admin
  # 1 = GM (but not website admin)
  # 2 = general

end
