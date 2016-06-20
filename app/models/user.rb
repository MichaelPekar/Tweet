class User < ActiveRecord::Base
  # has_many :posts, dependent: :destroy
  has_and_belongs_to_many :users,
  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates_presence_of :email, :name
  validates_uniqueness_of :email, :name

  def self.authenticate(name, email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end