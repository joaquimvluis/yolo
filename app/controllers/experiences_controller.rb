class ExperiencesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :test]
  def index
    @experiences = Experience.all

    if params[:query].present?
      @experiences = Experience.where(title: params[:query])
    else
      @experiences = Experience.all
    end

  end

  def test
    @experiences = Experience.where("title ILIKE ?", "%#{params[:query]}%")
  end

end
