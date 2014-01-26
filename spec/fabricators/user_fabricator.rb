Fabricator(:user) do
  name { sequence(:name ) { |i| "name-#{i}"} }
  email { sequence(:email) { |i| "user-#{i}@example.com"} }
end
