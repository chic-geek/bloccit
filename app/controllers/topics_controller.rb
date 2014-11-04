class TopicsController < ApplicationController
  ## each of the TopicsController class methods corresponds to a view template
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

  ## =================================================
  ## CREATE
  ## =================================================
  def create
    @topic = Topic.new(params.require(:topic).permit(:name, :description, :public))
    authorize @topic
    if @topic.save
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash[:error] = "Error creating topic. Please try again."
      render :new
    end
  end

  def new
     @topic = Topic.new
     authorize @topic
  end


  ## =================================================
  ## READ
  ## =================================================
  def index
     @topics = Topic.all
     authorize @topics
  end

  def show
     @topic = Topic.find(params[:id])
     @posts = @topic.posts
     authorize @topic
  end


  ## =================================================
  ## UPDATE
  ## =================================================
  def update
    @topic = Topic.find(params[:id])
    authorize @topic
    if @topic.update_attributes(params.require(:topic).permit(:name, :description, :public))
      redirect_to @topic
    else
      flash[:error] = "Error saving topic. Please try again"
      render :edit
    end
  end

  def edit
     @topic = Topic.find(params[:id])
     authorize @topic
  end


  ## =================================================
  ## DELETE
  ## =================================================
end
