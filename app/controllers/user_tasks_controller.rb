class UserTasksController < ApplicationController

  def index
    # @usertasks = UserTask.where(user: current_user)
    @user = current_user
    # authorize @usertasks
    # authorize @user
    @usertasks = policy_scope(UserTask).includes(task: :experience).order(:completed, 'tasks.deadline')
    @completed = UserTask.where(user: current_user, completed: true).count

    @users = policy_scope(User.all)

    if params[:query].present?
      @users = User.search_by_email(params[:query])
    end

    respond_to do |format|
      format.html
      format.text { render partial: 'user_tasks/list', locals: { users: @users }, formats: [:html] }
    end
  end

  # def new
  #   create
  # end

  # def create
  #   if params[:task_id].present? && params[:user_id].present?
  #     @task = Task.find(:task_id.to_i)
  #     @challengee = User.find(:user_id.to_i)
  #     UserTask.new(task: @task, user: @challengee, completed: false, owner: false)
  #   end
  # end

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

  private

  def user_task_params
    params.require(:user_task).permit(:completed)
  end
end
