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
    @topics = Topic.visible_to(current_user).paginate(page: params[:page], per_page: 10)
    authorize @topics
  end

  def show
    @topic = Topic.find(params[:id])
    authorize @topic
    @posts = @topic.posts.includes(:user).includes(:comments).paginate(page: params[:page], per_page: 10)
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
  # Go and pull out the topic by ID...
  # Get the topic name and assign to a variable in preparation for the
  # message / flash notice / error...
  # Will return either true or false if the topic was destroyed from the db
  # then display the relevant notice...
  #
  def destroy
    @topic = Topic.find(params[:id])
    name = @topic.name

    authorize @topic

    if @topic.destroy
      flash[:notice] = "\"#{name}\" was deleted successfully"
      redirect_to_topics_path
    else
      flash[:error] = "There was an error deleting the topic."
      render :show
    end

  end
end
