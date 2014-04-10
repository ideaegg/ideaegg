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
  belongs_to :commentable, polymorphic: true

  validates :commentable_type, presence: true
  validates :commentable, presence: true
  #validates :user_id, presence: true
  #validates :idea_id, presence: true
  validates :content, presence: true
  
  has_many :notifications, as: 'subject'
  
  after_create :create_mention_notifications, :create_comment_notifications
  
  def mention_users
    return @mention_users if defined?(@mention_users)
    
    usernames = content.scan(/@(\w+)/).flatten.compact.uniq
    @mention_users = User.where(name: usernames)
  end
  
  def create_mention_notifications
    users = mention_users - [user]
    
    users.each do |user|
      Notification.create(user: user,
                          subject: self,
                          name: 'mention')
    end
  end
  
  def create_comment_notifications
    if commentable.user != self.user
      Notification.create(user: commentable.user,
                          subject: self,
                          name: 'comment')
    end
  end

  def user_name
    user.name
  end
end
