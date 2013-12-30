# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  password_digest :string(255)
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  has_many :authentications, dependent: :destroy

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
end
