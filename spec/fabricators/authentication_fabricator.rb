Fabricator(:authentication) do
  provider { sequence(:provider) { |i| "provider-#{i}"} }
  user_id { sequence(:user_id) { |i| "user_id-#{i}"} }
  uid { sequence(:uid) { |i| "uid-#{i}"} }
  user
end
