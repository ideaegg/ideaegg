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

  def user_name
    user.name
  end
end
