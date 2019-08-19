class StaticPagesController < ApplicationController
  def home
    @travel_places = TravelPlace.popular_places
    @posts = Post.popular_posts
    @travel_place_types = TypeTravelPlace.pluck :name, :id
    @list_name = TravelPlace.all.pluck(:name)
    @list_address = TravelPlace.all.pluck(:address)
    @hotels = TravelPlace.get_type(1)
    @travels = TravelPlace.get_type(2)
    @foods = TravelPlace.get_type(3)
  end
end
