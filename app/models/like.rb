# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  idea_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Like < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :idea, counter_cache: true

  validates :user_id, presence: true, uniqueness: { scope: :idea_id }
  validates :idea_id, presence: true
end
