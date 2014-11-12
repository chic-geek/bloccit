class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  # A little validation to make sure that the user_id exists
  # the comment body is more than 5 characters and also exists.
  validates :user_id, presence: true
  validates :body, length: { minimum: 5 }
  validates :body, presence: true
end
