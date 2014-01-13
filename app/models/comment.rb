class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :idea_id, presence: true
  validates :content, presence: true
end
