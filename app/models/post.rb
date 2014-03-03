class Post < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true

  def belongs_to_user?(u)
    user == u
  end

  # tag
  acts_as_taggable
end
