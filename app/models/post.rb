class Post < ActiveRecord::Base
  validates_presence_of :title, :body

  belongs_to :user
end
