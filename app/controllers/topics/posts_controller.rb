class Topics::PostsController < ApplicationController
  ## each of the PostsController class methods corresponds to a view template
  ## for example, below we have index, show, new and edit. these correspond
  ## to...
  ##       - views/
  ##          - posts/
  ##             + index.html.erb
  ##             + show.html.erb
  ##             + new.html.erb
  ##             + edit.html.erb
  ##
  ## at the heart of all this is the CRUD (create, read, update, delete) methodolgy.

  #### =================================================
  #### CREATE
  #### =================================================
  #
  # start by creating an instance var which then stores a new instance of Post class.
  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post
  end

  # `create` method takes the new post and saves it, throwing back a notice (flash).
  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(post_params)
    @post.topic = @topic
    authorize @post

    if @post.save
      @post.create_vote
      flash[:notice] = "Post was saved."
      #redirect to the post within the topic in question
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  #### =================================================
  #### READ
  #### =================================================
  #
  # displays all posts on the posts/index page.
  # def index
  #   @posts = Post.all
  #   authorize @posts
  # end

  # we find and display the post by using find method passing in the id as a parameter.
  def show
    @topic = Topic.find(params[:topic_id])
    authorize @topic
    @post = Post.find(params[:id])

    # Speak to Eliot to help explain the bottom `.build` method
    @comments = @post.comments
    # @comment = @post.comments.build
  end


  #### =================================================
  #### UPDATE
  #### =================================================
  #
  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post

    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to @post
    else
      flash[:error] = "There was an error when saving the post, please try again."
      render :edit
    end
  end


  ### =================================================
  ### DELETE
  ### =================================================
  # Process is similar to deleting a topic entry, see topic ctrl for more.
  #
  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    title = @post.title
    authorize @post

    if @post.destroy
      flash[:notice] = "\"#{title}\" was deleted successful"
      redirect_to @topic
    else
      flash[:error] = "There was an error deleting the post"
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

end
