class PostsController < ApplicationController
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
      flash[:notice] = "Post was saved."
      redirect_to @post
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
    @post = Post.find(params[:id])
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

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
