class FavoriteMailer < ActionMailer::Base
  default from: "favorites@bloccitapp.com"

  def new_comment(user, post, comment)

    # New headers
    headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
    headers["References"] = "<post/#{post.id}@your-app-name.example>"

    # `NOTE` Ask Eliot what these three instance vars are for?
    # Think they are for the html and text mailers but not sure?
    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")

  end
end
