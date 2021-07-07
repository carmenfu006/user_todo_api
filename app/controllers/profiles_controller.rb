class ProfilesController < ApplicationController
  def show
    if session['token']
      user_response = RestClient.get "http://localhost:3000/api/v1/users/#{session['user_id']}", header
      tasks_response = RestClient.get "http://localhost:3000/api/v1/users/#{session['user_id']}/tasks", header
      @user = JSON.parse(user_response)
      @tasks = JSON.parse(tasks_response)
    end
  end

  private
    def header
      {
        content_type: :json,
        accept: :json,
        authorization: "Bearer #{session['token']}"
      }
    end
end