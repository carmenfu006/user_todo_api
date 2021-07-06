class RegistersController < ApplicationController
  def new
  end

  def create
    response = RestClient.post "http://localhost:3000/api/v1/users",
    {
      'user': {
        email: params[:email],
        password: params[:password],
        password_confirmation: params[:password_confirmation]
      }
    }.to_json, content_type: 'application/json'

    if response.code == 201
      user = JSON.parse(response)
      session['token'] = user['token']
      session['user_id'] = user['id']
      redirect_to profile_path("#{session['user_id']}")
    else
      redirect_to root_path
    end
  end
end