class TasksController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show create]
  before_action :set_experience, only: %i[create]

  def create
    @task = Task.new(task_params)
    # @task.user = current_user
    @task.experience = @experience
    # authorize @task
    @task.save
    raise
    if @task.save
      redirect_to experiences_path
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:deadline, :penalty)
  end

  def set_experience
    @experience = Experience.find(params[:experience_id])
  end

end
