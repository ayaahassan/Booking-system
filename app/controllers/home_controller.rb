class HomeController < ApplicationController
  def index
    @upcoming_workshops=Workshop.upcoming_workshops
    @past_workshops=Workshop.past_workshops
  end
end
