class SessionsController < ApplicationController

  def create
    user_data = request.env['omniauth.auth']
    binding.pry
    token = user_data[:credentials][:token]
    uid = user_data[:uid]
    name = user_data[:info][:name]
    email = user_data[:info][:email]

    user = User.find_or_create_by(uid: uid)
    user.name = name
    user.email = email
    user.token = token
    user.save
binding.pry
    redirect_to dashboard_path
  end

end
