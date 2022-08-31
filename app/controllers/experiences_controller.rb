class ExperiencesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show test]
  before_action :set_experience, only: %i[show]

  def index
    @experiences = Experience.all
    @experiences = policy_scope(Experience)
    @categories = Category.all
    @categories = policy_scope(Category)
  end

  def results
    # @experiences = Experience.all
    if params[:query].present?
      # @experiences = policy_scope(Experience).search_by_title_and_description(params[:query]
      @experiences = Experience.search_by_title_and_description(params[:query])
      authorize @experiences

    elsif params[:category].present?
      @experiences = policy_scope(Experience).where(category: params[:category])
    else
      @experiences = policy_scope(Experience)
    end
  end

  def show
    @task = Task.new
    authorize @task
  end

  private

  def set_experience
    @experience = Experience.find(params[:id])
    authorize @experience
  end

  def task_params
    params.require(:task).permit(:name, :deadline, :location, :capacity, :category, :price, :photo)
  end
end
