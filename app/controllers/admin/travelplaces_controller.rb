class Admin::TravelplacesController < ApplicationController
  protect_from_forgery prepend: true, with: :exception
  skip_before_action :verify_authenticity_token
  before_action :load_travel, only: %i(show edit update destroy)
  layout "admin"
  def index
    @travels = TravelPlace.all.page(params[:page]).per Settings.item_page
    @cities = City.all
    @types = TypeTravelPlace.all
  end

  def new
    @travel = TravelPlace.new
  end

  def create
    @travel = TravelPlace.new travel_params
    if @travel.save
      respond_to do |format|
        format.html{redirect_to admin_travelplaces_path}
        format.js
      end
    else
      flash[:danger] = t ".add_fails"
      redirect_to admin_travelplaces_path
    end
  end

  def edit
    respond_to do |format|
      format.json{render json: @travel.to_json}
    end
  end

  def update
    respond_to do |format|
      if @travel.update_attributes travel_params
        format.html{redirect_to admin_travelplaces_path}
        format.js
      else
        flash[:danger] = t ".edit_fails"
        redirect_to admin_travelplaces_path
      end
    end
  end

  def destroy
    return unless @travel.destroy
    flash[:danger] = t ".dele_fails"
    redirect_to admin_travelplaces_path
  end

  private

  def travel_params
    params.permit :name, :content, :address, :type_travel_place_id, :city_id
  end

  def load_travel
    @travel = TravelPlace.find_by id: params[:id]
    return if @travel
    flash[:danger] = t ".danger"
    redirect_to admin_root_path
  end
end
