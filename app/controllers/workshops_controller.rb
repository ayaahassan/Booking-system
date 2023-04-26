class WorkshopsController < ApplicationController

    def index
        @workshops=Workshop.upcoming_workshops
    end   
    
    def show
        @workshop=Workshop.friendly.find(params[:id])
    end    
end
