class User < ActiveRecord::Base
  validates :email, :name, :password_digest, :user_type, presence: true
  validates :email, :name, uniqueness: { case_sensitive: false }

  has_many :comments
  has_many :characters

  enum user_type: [ :admin, :gm, :player ]

  before_save { |user| user.email = email.downcase }

  has_secure_password

end
