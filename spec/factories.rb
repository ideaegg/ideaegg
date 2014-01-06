FactoryGirl.define do
  factory :user do
    name     "John Doe"
    email    "john@example.com"
    password_digest "foobar"
  end
end
