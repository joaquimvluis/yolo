class UserTasksController < ApplicationController

  def index
    # @usertasks = UserTask.where(user: current_user)
    @user = current_user
    # authorize @usertasks
    # authorize @user
    @usertasks = policy_scope(UserTask).includes(task: :experience).order(:completed, 'tasks.deadline')
    if params[:status].present?
     @usertasks = @usertasks.where(user: current_user, completed: params[:status]=="true")
    end

    @completed = UserTask.where(user: current_user, completed: true).count
    @alltasks = UserTask.where(user: current_user).count
    @open = @alltasks - @completed
  end

  def completed
    # usertask.completed
    @completed = UserTask.where(user: current_user, completed: true).count
    authorize :user_task, :completed?
    respond_to do |format|
      format.json
    end
  end

  def open
    # usertask.completed
    @open = UserTask.where(user: current_user, completed: false).count
    authorize :user_task, :open?
    respond_to do |format|
      format.json
    end
  end

  def update
    @usertask = UserTask.find(params[:id])
    @usertask.update(user_task_params)
    authorize(@usertask)

    head :ok
  end

  def destroy
    @usertask = UserTask.find(params[:id])
    @usertask.destroy
    redirect_to user_user_tasks_path(current_user), status: :see_other
    authorize @usertask
  end

  private

  def user_task_params
    params.require(:user_task).permit(:completed)
  end
end
