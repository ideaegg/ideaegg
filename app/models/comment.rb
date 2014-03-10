# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  idea_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  validates :user_id, presence: true
  validates :idea_id, presence: true
  validates :content, presence: true
  
  has_many :notifications, as: 'subject'
  
  after_create :create_mention_notifications, :create_comment_notifications
  
  def create_mention_notifications
  end
  
  def create_comment_notifications
    Notification.create(user: idea.user,
                        subject: self,
                        name: 'comment')
  end

  def user_name
    user.name
  end
end
