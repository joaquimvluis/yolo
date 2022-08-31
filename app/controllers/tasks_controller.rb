class TasksController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_experience, only: %i[create]

  def create
    @task = Task.new(task_params)
    @usertask = UserTask.new(usertask_params)
    # @task.users = current_user
    @task.experience = @experience
    @usertask.task = @task
    @usertask.user = current_user
    @usertask.owner = true
    # authorize @task
    @task.save
    authorize @task
    @usertask.save
    respond_to do |format|
      if @task.save
        format.html { redirect_to experience_url(@experience), notice: "Task was successfully created." }
        # format.json { render :show, status: :created, location: @experience }
      else
        format.html { render "experiences/show", status: :unprocessable_entity }
        # format.json { render json: @experience.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def task_params
    params.require(:task).permit(:deadline, :penalty)
  end

  def usertask_params
    params.require(:task).permit(:task_id, :user_id)
  end

  def set_experience
    @experience = Experience.find(params[:experience_id])
  end


end
