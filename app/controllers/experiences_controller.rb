class ExperiencesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  before_action :set_experience, only: %i[show]

  def results
    # @experiences = Experience.all
    if params[:query].present?
      @experiences = policy_scope(Experience).search_by_title_and_description(params[:query])
    elsif params[:category].present?
      @experiences = policy_scope(Experience).where(category: params[:category])
    else
      @experiences = policy_scope(Experience)
    end
  end

  def show
  end

  private

  def set_experience
    @experience = Experience.find(params[:id])
  end
end
