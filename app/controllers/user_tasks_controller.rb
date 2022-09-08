class UserTasksController < ApplicationController

  def index
    # @usertasks = UserTask.where(user: current_user)
    @user = current_user
    # authorize @usertasks
    # authorize @user
    @usertasks = policy_scope(UserTask).includes(task: :experience).order(:completed, 'tasks.deadline').where(user: current_user)
    if params[:status].present?
     @usertasks = @usertasks.where(user: current_user, completed: params[:status]=="true")
    end

    @completed = UserTask.where(user: current_user, completed: true).count
    @open = UserTask.where(user: current_user, completed: false).count

    @users = policy_scope(User.all)

    if params[:query].present?
      @users = User.search_by_email(params[:query])
    end

    respond_to do |format|
      format.html
      format.text { render partial: 'user_tasks/list', locals: { users: @users }, formats: [:html] }
    end
  end

  def new
    create
  end

  def create
    if params[:task_id].present? && params[:user_id].present?
      @task = Task.find(params[:task_id])
      @challengee = User.find(params[:user_id])
      @usertask = UserTask.new(task: @task, user: @challengee, completed: false, owner: false)

      authorize @usertask

      respond_to do |format|
        if @usertask.save
          format.html { redirect_to user_user_tasks_path(current_user) }
          format.json # Follow the classic Rails flow and look for a create.json view
        else
          format.html { render user_user_tasks_path(current_user), status: :unprocessable_entity }
          format.json # Follow the classic Rails flow and look for a create.json view
        end
      end
    end
  end

  def completed?
    usertask.completed
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
