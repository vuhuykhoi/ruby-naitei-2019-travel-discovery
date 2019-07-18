class TravelPlace < ApplicationRecord
  belongs_to :type_travel_place
  belongs_to :city

  has_many :travel_place_images, dependent: :destroy
  scope :order_by_name, ->(_name){order :name}
  scope :popular_places, ->{order(rate_point: :desc).take Settings.popular_places}

  scope :get_places, ->(name, address, type){where(name: name) | where(address: address) | where(type_travel_place_id: type)}
  scope :search_by_name, ->(name){where "name like ?", name}

  validates :name, presence: true
  validates :city_id, presence: true

  delegate :name, to: :city, prefix: :city, allow_nil: true
end
