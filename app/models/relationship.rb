class Relationship < ActiveRecord::Base
  # belongs_to :followers, class_name: User, foreign_key: :follower_id
  # belongs_to :followeds,  class_name: User, foreign_key: :followed_id
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
