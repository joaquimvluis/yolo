class ExperiencesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :test]
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

end
