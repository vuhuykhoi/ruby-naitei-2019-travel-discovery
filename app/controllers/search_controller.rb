class SearchController < ApplicationController
  def index
    if params[:what].blank? && params[:location].blank? && params[:type].blank?
      redirect_to root_path
    else
      @travel_places = TravelPlace
                       .get_places(params[:what],
                         params[:search],
                         params[:type])
    end
  end
end
