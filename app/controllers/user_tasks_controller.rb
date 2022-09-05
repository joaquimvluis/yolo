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

  def destroy
    @usertask = UserTask.find(params[:id])
    @usertask.destroy
    redirect_to user_user_tasks_path(current_user), status: :see_other
    authorize @usertask
  end

  def test
    @users = policy_scope(User)
  end

  private

  def user_task_params
    params.require(:user_task).permit(:completed)
  end
end
