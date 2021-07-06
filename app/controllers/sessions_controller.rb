class SessionsController < ApplicationController

  def new
  end

  def create
    response = RestClient.post "http://localhost:3000/api/v1/auth/login",
    {
      'user': {
        email: params[:email],
        password: params[:password]
      }
    }.to_json, content_type: 'application/json'

    if response.code == 200
      user = JSON.parse(response)
      session['token'] = user['token']
      session['user_id'] = user['id']
      redirect_to profile_path("#{session['user_id']}")
    else
      redirect_to root_path
    end
  end

  def destroy
    session['token'] = nil
    session['user_id'] = nil
    redirect_to root_path
  end
end