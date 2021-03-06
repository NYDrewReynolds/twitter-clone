class TweetsController < ApplicationController
  def create
    current_user.update_status(params[:tweet])
    redirect_to feed_path
  end

  def update
    current_user.favorite(params[:id])
    redirect_to feed_path
  end
end
