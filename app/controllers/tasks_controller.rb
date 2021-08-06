class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    puts "Current User yooo #{Task.all.where(user_id: get_current_user.id)}"
    render json: Task.all.where(user_id: get_current_user.id).order(created_at: :desc)
  end 


  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
  end

  def update
    task = Task.find(params[:id])
    if task.update(task_params)
        render json: task, status: 201 
    else
        render json: {errors: task.errors.full_message }, status: 422
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    render json: task, status: :ok
  end

  # POST /tasks or /tasks.json
  
  def create
    task = Task.create(task_params)
    task.user = get_current_user()
    puts "New task: #{task}"
    if task
      render json: task
    else
      render json: @task.error.full_messages, status: 402
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task = Task.find(params[:id])

    if @task.destroy
      render :show
    else
      render json: @task.errors.full_messages, status: 402
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:id, :title, :description, :user_id)
    end
end
