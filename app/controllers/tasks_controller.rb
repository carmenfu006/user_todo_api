class TasksController < ApplicationController

  def create
    response = RestClient.post "http://localhost:3000/api/v1/users/#{session['user_id']}/tasks",
        { 
          'task': {
            title: params[:title]
          }
        }.to_json, header

    if response.code == 201
      redirect_to profile_path("#{session['user_id']}")
    else
      redirect_to root_path
    end
  end

  def edit
    response = RestClient.get "http://localhost:3000/api/v1/users/#{session['user_id']}/tasks/#{params[:id]}", header
    @task = JSON.parse(response)
  end

  def update
    response = RestClient.put "http://localhost:3000/api/v1/users/#{session['user_id']}/tasks/#{params[:id]}",
    { 
      'task': {
        title: params[:title]
      }
    }.to_json, header

    if response.code == 200
      redirect_to profile_path("#{session['user_id']}")
    else
      redirect_to root_path
    end
  end

  def status
    response = RestClient.put "http://localhost:3000/api/v1/users/#{session['user_id']}/tasks/#{params[:task_id]}",
    { 
      'task': {
        completed: params[:completed]
      }
    }.to_json, header

    if response.code == 200
      redirect_to profile_path("#{session['user_id']}")
    else
      redirect_to root_path
    end
  end

  def destroy
    response = RestClient.delete "http://localhost:3000/api/v1/users/#{session['user_id']}/tasks/#{params[:id]}", header
    redirect_to profile_path("#{session['user_id']}")
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