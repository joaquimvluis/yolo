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
    # respond_to do |format|
    #   if @task.save
    #     format.html { redirect_to experience_url(@experience), notice: "Task was successfully created." }
    #     # format.json { render :show, status: :created, location: @experience }
    #   else
    #     format.html { render "experiences/add_experience_modal", status: :unprocessable_entity }
    #     # format.json { render json: @experience.errors, status: :unprocessable_entity }
    #   end
    respond_to do |format|
      if @task.save
        format.html { redirect_to experience_url(@experience), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @experience }
        format.js { render :show, status: :created, location: @experience }
        @usertask.save
      else
        format.html { render partial: "experiences/add_experience_modal", locals: {experience: @experience, task: @task}, notice: "Task was successfully created."}
        format.json { render json: @experience.errors, status: :unprocessable_entity }
        format.js   { render :show }
      end
    end
  end

  def destroy
    @task = UserTask.find(params[:id])
    @task.destroy
    redirect_to user_user_tasks_path(current_user), status: :see_other
    authorize @task
  end

  private

  def task_params
    params.require(:task).permit(:deadline, :penalty, :title)
  end

  def usertask_params
    params.require(:task).permit(:task_id, :user_id)
  end

  def set_experience
    @experience = Experience.find(params[:experience_id])
  end


end
