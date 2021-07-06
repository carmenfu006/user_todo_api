class ProfilesController < ApplicationController
  def show
    if session['token']
      response = RestClient.get "http://localhost:3000/api/v1/users/#{session['user_id']}",
        {
          content_type: :json,
          accept: :json,
          authorization: "Bearer #{session['token']}"
        }
        @user = JSON.parse(response)
    end
  end
end