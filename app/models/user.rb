class User < ApplicationRecord
  attr_accessor :remember_token
  before_save :downcase_email, :downcase_gender

  has_many :posts, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
                                  foreign_key: :follower_id,
                                  dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
                                   foreign_key: :followed_id,
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  mount_uploader :avatar, PictureUploader

  validates :username, presence: true,
  length: {maximum: Settings.user.validates.max_name_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
  length: {maximum: Settings.user.validates.max_email_length},
  format: {with: VALID_EMAIL_REGEX},
  uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, allow_nil: true,
  length: {minimum: Settings.user.validates.min_pass_length}

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def liked_post_users reaction_type_id, post_id
      joins(:reactions).where("reaction_type_id = ? and post_id = ?",
        reaction_type_id, post_id)
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  def having_reaction?user_id, post_id
    reactions.find_by user_id: user_id, post_id: post_id
  end

  private

  def downcase_email
    email.downcase!
  end

  def downcase_gender
    gender.downcase!
  end
end
