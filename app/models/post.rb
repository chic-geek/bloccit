class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :topic

  default_scope { order('rank DESC') }

  scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }

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

  mount_uploader :image, ImageUploader

  # Method to get a collection of up_votes then count them up.
  # (Uses ActiveRecords 'where' method).
  def up_votes
    self.votes.where(value: 1).count
  end

  def down_votes
    self.votes.where(value: -1).count
  end

  # Using sum method pass in the value as a symbol to be 'summed' up.
  def points
    self.votes.sum(:value)
  end

  def update_rank
    age = (created_at - Time.new(1970,1,1)) / (60 * 60 * 24) # 1 day in seconds
    new_rank = points + age

    update_attribute(:rank, new_rank)
  end

  def create_vote
    user.votes.create(value: 1, post: self)
  end
end
