class User < ActiveRecord::Base
  attr_accessible :vorname, :nachname, :email, :password, :password_confirmation
  has_many :works
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :nachname, presence: true, length: { maximum: 50 }
  validates :vorname, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
            format:     { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 4 }
  validates :password_confirmation, presence: true

  def user_name
    "#{vorname} #{nachname}"
  end

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end


end
