class CommentsController < ApplicationController

  # Fill in the create action. It should create a new comment associated
  # with a post and the current_user who created it.
  #
  def create
    # Find topic by the parameter topic_id and assign it the @topic instance var...
    # Within said topic, grab the post that matched the parameter post_id and assign to @post...
    # Take that very post and create a new comment with the new parameters set in `comment_params`...
    # Get the user_id... this will either be Nil or the current_user.id (whatever # that happens to be)...
    # If comment was saved, redirect to the topics post with success comment else the fail message if it wasn't.
    #
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to [@topic, @post], notice: "Comment saved successfully."
    else
      redirect_to [@topic, @post], notice: "Comment failed to save."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
