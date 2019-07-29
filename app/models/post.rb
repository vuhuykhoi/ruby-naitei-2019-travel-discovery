class Post < ApplicationRecord
  has_many :post_images, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :travel_place

  scope :create_desc, ->{order created_at: :desc}

  validates :user_id, presence: true
  validates :travel_place_id, presence: true
  validates :title, presence: true
  validates :content, presence: true

  delegate :name, to: :travel_place, prefix: :travel_place, allow_nil: true
  delegate :address, to: :travel_place, prefix: :travel_place, allow_nil: true

  def num_of_likes
    reactions.where("reaction_type_id = ?", Settings.reaction_type.like).count
  end

  def num_of_comments
    comments.count
  end
end
