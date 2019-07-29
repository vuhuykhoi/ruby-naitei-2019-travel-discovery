class StaticPagesController < ApplicationController
  def home
    @travel_places = TravelPlace.popular_places
    @posts = Post.popular_posts
  end
end
