class SessionsController < ApplicationController

  def create
    user_data = request.env['omniauth.auth']
    binding.pry
    token = user_data[:credentials][:tokken]
    uid = user_data[:uid]
  end

end
