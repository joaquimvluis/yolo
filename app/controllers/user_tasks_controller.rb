class UserTasksController < ApplicationController

  def index
    # @usertasks = UserTask.where(user: current_user)
    @user = current_user
    # authorize @usertasks
    # authorize @user
    @usertasks = policy_scope(UserTask).includes(task: :experience).order(:completed, 'tasks.deadline')
    @completed = UserTask.where(user: current_user, completed: true).count
  end

  def completed?
    usertask.completed
  end

  def update
    @usertask = UserTask.find(params[:id])
    @usertask.update(user_task_params)
    authorize(@usertask)

    head :ok
  end

  private

  def user_task_params
    params.require(:user_task).permit(:completed)
  end
end
