class ExperiencesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @experiences = Experience.all
  end
end
