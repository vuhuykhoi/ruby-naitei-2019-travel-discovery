class SearchController < ApplicationController
  def index
    if params[:what].blank? && params[:location].blank?
      redirect_to(root_path)
    else
      @travel_places = TravelPlace
                       .where("lower(name) LIKE :search",
                         search: params[:what])
      @travel_places += TravelPlace
                        .where("lower(address) LIKE :search",
                          search: params[:location])
      @travel_places += TravelPlace
                        .where("type_travel_place_id LIKE :search",
                          search: params[:type])
    end
  end
end
