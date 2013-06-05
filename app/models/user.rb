class User < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :email, :password, :password_confirmation, :photo, :login
  has_many :works, dependent: :restrict
  has_secure_password
  has_attached_file :photo

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :lastname, presence: true, length: { maximum: 50 }
  validates :firstname, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
            format:     { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 4 }
  validates :password_confirmation, presence: true

  def user_name
    "#{firstname} #{lastname}"
  end


  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end


end
