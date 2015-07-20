class SessionsController < ApplicationController

  def create
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user
      session[:user_id] = @user.id
      redirect_to feed_path
    else
      redirect_to root_path
    end
  end

  # def create
  #   render text: request.env["omniauth.auth"].inspect
  # end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def oauth
    request.env['omniauth.auth']
  end

end
