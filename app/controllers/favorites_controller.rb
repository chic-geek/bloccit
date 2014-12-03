class FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)
    authorize favorite

    if favorite.save
      # Add code to generate a success flash and redirect to @post
      # Remember the path shortcut: [@post.topic, @post]

      flash[:notice] = "Successfully favourited."
      redirect_to [@post.topic, @post]
    else
      # Add code to generate a failure flash and redirect to @post

      flash[:error] = "An error occurred whist trying to favourite, please try again."
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    # Get the post from the params
    # Find the current user's favorite with the ID in the params

    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find(params[:id])
    authorize favorite

    if favorite.destroy
      # Flash success and redirect to @post

      flash[:success] = "Favourite removed"
      redirect_to [@post.topic, @post]
    else
      # Flash error and redirect to @post

      flash[:error] = "An error occurred whilst trying to remove favourite, please try again."
      redirect_to [@post.topic, @post]
    end
  end

end
