class UserTasksController < ApplicationController

  def index
    @usertasks = UserTask.where(user: current_user)
    @user = current_user
    @usertasks = policy_scope(UserTask)
  end

end
