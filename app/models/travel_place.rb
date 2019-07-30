class TravelPlace < ApplicationRecord
  belongs_to :type_travel_place
  belongs_to :city

  has_many :travel_place_images, dependent: :destroy

  scope :popular_places, ->{order(rate: :desc).take Settings.popular_places}
  scope :get_places, ->(name, address, type){where(name: name) | where(address: address) | where(type_travel_place_id: type)}
end
