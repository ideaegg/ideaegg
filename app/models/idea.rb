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
#  collections_count :integer    default(0)
#

class Idea < ActiveRecord::Base
  #soft delete
  #bug: when rake db:migrate RAILS_ENV=test
  #error: no delete_at column
  #answer: comment this line, run rake db:migrate RAILS_ENV=test,
  #        then uncomment this line
  acts_as_paranoid

  belongs_to :user
  has_many :comments, as: 'commentable', dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user, dependent: :destroy
  has_many :collections

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :description, presence: true
  
  after_create :create_mention_notifications
  after_destroy :cancel_collect

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
  
  def cancel_collect
    @idea = Idea.with_deleted.where(id: self.id).first
    if self.user.collected?(@idea)
      self.user.collections.where(idea_id: @idea.id).destroy_all 
    end
  end

  #tag
  acts_as_taggable
end
