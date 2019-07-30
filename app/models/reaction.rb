class Reaction < ApplicationRecord
  belongs_to :reaction_type
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates_uniqueness_of :user_id, scope: :post_id
end
