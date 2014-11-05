class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  belongs_to :topic

  default_scope { order('created_at DESC') }

  # Validations are like boucers of a club, they only let in people
  # that fit the criteria, below we're asking a for the following:
  # a posts title to be at least 5 chars long and exist,
  # a posts body to be at least 20 chars long and exist,
  # a post to be associated with a topic
  # and a post to be associated with a user.
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
