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
    def create_with_omniauth(auth)
      create do |user|
        user.name = auth[:info][:name]
        user.email = auth[:info][:email]
        user.authentications_attributes = Authentication.new({
          provider: auth[:provider],
          uid: auth[:uid]
        }).attributes
      end
    end
  end
end
