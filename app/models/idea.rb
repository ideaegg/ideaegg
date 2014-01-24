class Idea < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :idea_likes, dependent: :destroy
  has_many :liking_users, through: :idea_likes, source: :user

  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :description, presence: true

  def belongs_to_user?(u)
    user == u
  end
end
