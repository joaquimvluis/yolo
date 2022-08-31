class ExperiencesController < ApplicationController

  skip_before_action :authenticate_user!, only: %i[index show test]
  before_action :set_experience, only: %i[show]

  def index
    @experiences = Experience.all
    @categories = Category.all

    if params[:query].present?
      raise
      Experience.search_by_title_and_description(params[:query])
    else
      @experiences = Experience.all
    end
  end

  def test
    @experiences = Experience.search_by_title_and_description(params[:query])
  end

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
