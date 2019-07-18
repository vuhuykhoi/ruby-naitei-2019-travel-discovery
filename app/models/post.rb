class Post < ApplicationRecord
  has_many :post_images, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :travel_place

  validates :user_id, presence: true
  validates :travel_places_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
end
