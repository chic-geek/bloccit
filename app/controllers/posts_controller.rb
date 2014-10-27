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
    @post = Post.new
  end

  # `create` method takes the new post and saves it, throwing back a notice (flash).
  def create
    @post = current_user.posts.build(params.require(:post).permit(:title, :body))
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
  def index
    @posts = Post.all
  end

  # we find and display the post by using find method passing in the id as a parameter.
  def show
    @post = Post.find(params[:id])
  end


  #### =================================================
  #### UPDATE
  #### =================================================
  #
  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params.require(:post).permit(:title, :body))
      flash[:notice] = "Post was updated."
      redirect_to @post
    else
      flash[:error] = "There was an error when saving the post, please try again."
      render :edit
    end
  end

end
