class User < ApplicationRecord
  #############
  # Relations #
  #############
  has_many :courses
  has_many :sections
  has_many :lessons
  
  ############################
  # Validations #
  ############################

  # Username validation
  validates :username, presence: true, length: { minimum: 6 }, uniqueness: true
  # Password validation
  validates :password, presence: true, length: { minimum: 6 }
  # Email validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, 
    length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: true

  ############
  # Security #
  ############

  before_save { email.downcase! }
  has_secure_password

  #############
  # Functions #
  #############

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : 
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
