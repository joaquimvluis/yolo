class ExperiencesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  before_action :set_experience, only: %i[show]

  def show
    @task = Task.new
  end

  private

  def set_experience
    @experience = Experience.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :deadline, :location, :capacity, :category, :price, :photo)
  end

end
