class TravelPlace < ApplicationRecord
  belongs_to :type_travel_place
  belongs_to :city

  has_many :travel_place_images, dependent: :destroy
end
