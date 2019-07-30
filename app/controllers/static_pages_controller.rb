class StaticPagesController < ApplicationController
  def home
    @travel_places = TravelPlace.popular_places
    @posts = Post.popular_posts
    @travel_place_types = TypeTravelPlace.all
    @list_name = TravelPlace.all.pluck(:name)
    @list_address = TravelPlace.all.pluck(:address)
  end
end
