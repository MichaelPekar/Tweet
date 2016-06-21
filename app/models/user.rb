class User < ActiveRecord::Base
  # has_many :relationships, foreign_key: :followed_id
  # has_many :revers_relationships, class_name: Relationship, foreign_key: :follower_id
  # has_many :followers, through: :relationships
  # has_many :followeds, through: :revers_relationships

  attr_accessor :password
  before_save :encrypt_password

  # validates_confirmation_of :password
  # validates_presence_of :password, on: :create
  # validates_presence_of :email, :name
  # validates_uniqueness_of :email, :name

  def self.authenticate(name, email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def followers
    ids = Relationship.where(follower_id: self.id).pluck(:id)
    User.where(id: ids)
  end

  def followeds
    ids = Relationship.where(followed_id: self.id).pluck(:id)
    User.where(id: ids)
  end

  def add_follower(user_id)
    Relationship.create(follower_id: self.id, followed_id: user_id)
  end

  def unfollow(user_id)
    Relationship.where(follower_id:  self.id, followed_id: user_id).destroy_all
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end

