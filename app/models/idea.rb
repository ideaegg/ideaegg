# == Schema Information
#
# Table name: ideas
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  likes_count :integer          default(0)
#  hits_count  :integer          default(0)
#

class Idea < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user, dependent: :destroy

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :description, presence: true
  
  after_create :create_mention_notifications

  def belongs_to_user?(u)
    user == u
  end
  
  def mention_users
    []
  end
  
  def create_mention_notifications
    users = mention_users
    
    users.each do |user|
      create_mention_notification user
    end
  end
  
  def create_mention_notification(user)
    Notification.create(user: user,
              subject: self,
              name: 'mention')
  end

  #tag
  acts_as_taggable
end
