class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  # A little validation to make sure that the user_id exists
  # the comment body is more than 5 characters and also exists.
  validates :user_id, presence: true
  validates :body, length: { minimum: 5 }
  validates :body, presence: true

  # After a comment is created, we call send_favorite_emails.
  # This method grabs the post, finds all of the favorites associated
  # with it, and loops over them. For each favorite, it will
  # create and send a new email.
  after_create :send_favorite_emails

  private

  def send_favorite_emails
    post.favorites.each do |favorite|
      if should_receive_update_for?(favorite)
        FavoriteMailer.new_comment(favorite.user, self.post, self).deliver
      end
    end
  end

  private

  def should_receive_update_for?(favorite)
    user_id != favorite.user_id && favorite.user.email_favorites?
  end

end
