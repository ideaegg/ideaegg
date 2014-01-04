# == Schema Information
#
# Table name: identities
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Identity < OmniAuth::Identity::Models::ActiveRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A\w+\z/, message: '只允许数字、大小写字母和下划线' }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i }
end
