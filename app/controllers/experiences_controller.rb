class ExperiencesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show test]
  before_action :set_experience, only: %i[show]

  def index

    @experiences = policy_scope(Experience)
    @categories = policy_scope(Category)
  end

  def results
    if params[:query].present?
      @experiences = Experience.search_by_title_and_description(params[:query])
    elsif params[:category].present?
      @category = Category.find(params[:category])
      @experiences = Experience.includes(:experience_categories).where(experience_categories: { category_id: params[:category] })
    else
      @experiences = policy_scope(Experience)
    end
    authorize @experiences
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
