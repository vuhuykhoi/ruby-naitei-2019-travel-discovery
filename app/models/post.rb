class Post < ApplicationRecord
  has_many :post_images, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :travel_place

  accepts_nested_attributes_for :post_images, allow_destroy: true,
    reject_if: proc{|attributes| attributes["image"].blank?}

  scope :create_desc, ->{order created_at: :desc}
  scope :popular_posts, ->{order(view: :desc).take Settings.popular_posts}

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

  def travel_place_name
    travel_place.try(:name)
  end

  def travel_place_name=name
    return unless name.present?
    self.travel_place = TravelPlace.find_or_create_by(name: name)
  end
end
