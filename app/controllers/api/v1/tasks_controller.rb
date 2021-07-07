class Api::V1::TasksController < Api::V1::ApplicationController
  before_action :authorize_request
  before_action :find_user
  before_action :find_task, only: [:show, :update, :destroy]

  # GET /users/1/tasks 
  def index
    @tasks = @user.tasks
    render json: @tasks, status: :ok
  end

  # GET /users/1/tasks/1
  def show
    render json: @task, status: :ok
  end

  #  POST /users/1/tasks
  def create
    @task = @user.tasks.create(task_params)

    if @task.save
      render json: @task, status: :created
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /users/1/tasks/1
  def update
    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /users/1/tasks/1
  def destroy
    @task.destroy
    # with status 204, request was successfully processed but is not returning any content
  end


  private
    def find_user
      @user = User.find(params[:user_id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, status: :not_found
    end

    def find_task
      @task = Task.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Task not found' }, status: :not_found
    end

    def task_params
      params.require(:task).permit(:title, :completed)
    end
end