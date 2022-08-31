class ExperiencesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  before_action :set_experience, only: %i[show]

  def show
  end

  private

  def set_experience
    @experience = Experience.find(params[:id])
  end

end
