class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :create_desc, ->{order(created_at: :desc)}

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :content, presence: true
end
