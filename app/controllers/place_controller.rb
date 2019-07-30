class PlaceController < ApplicationController

  def hotel
    @hotels = TravelPlace.where("type_travel_place_id = 1")
  end

  def travel
    @travels = TravelPlace.where("type_travel_place_id = 2")
  end

  def food
    @foods = TravelPlace.where("type_travel_place_id = 3")
  end
end
