FactoryGirl.define do
  factory :user do
    name     "John Doe"
    email    "john@example.com"
    password_digest "foobar"
  end

  factory :idea do
    title       "Hello"
    description "Lorem ipsum"
    user
  end
end
