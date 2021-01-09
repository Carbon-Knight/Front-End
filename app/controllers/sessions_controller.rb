class SessionsController < ApplicationController

  def create
    user_data = request.env['omniauth.auth']

    user = User.find_or_create_by(uid: user_data[:uid])
    user.name = user_data[:info][:name]
    user.email = user_data[:info][:email]
    user.token = user_data[:credentials][:token]
    user.save

    session[:user_id] = user.id
    redirect_to dashboard_path
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = 'You are now logged out!'

    redirect_to root_path
  end
end
