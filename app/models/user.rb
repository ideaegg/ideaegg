# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  email       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  likes_count :integer          default(0)
#

class User < ActiveRecord::Base
  has_many :ideas, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :like_ideas, through: :likes, source: :idea, dependent: :destroy
  has_many :posts, dependent: :destroy

  accepts_nested_attributes_for :authentications

  class << self
    def from_auth(auth)
      locate_auth(auth) || create_with_omniauth(auth)
    end

    def create_with_omniauth(auth)
      create! do |user|
        user.name = auth[:info][:name]
        user.email = auth[:info][:email]
        user.authentications_attributes = Authentication.new({
          provider: auth[:provider],
          uid: auth[:uid]
        }).attributes
      end
    end

    def locate_auth(auth)
      Authentication.find_by_provider_and_uid(auth[:provider], auth[:uid]).try(:user)
    end
  end

  def like?(idea)
    idea && like_ideas.include?(idea)
  end

  # tag
  acts_as_tagger

  # Remember me
  def generate_remember_token
    begin
      token = SecureRandom.urlsafe_base64(15).tr('lIO0', 'fAhz')
    end while self.class.where({ remember_token: token }).exists?
    token
  end
  def remember_me
    self.remember_token ||= generate_remember_token
    save(validate: false) if changed?
  end
  def remember_me!
    self.remember_token = generate_remember_token
    save(validate: false)
  end
end
