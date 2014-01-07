Fabricator(:identity) do
  name { sequence(:name) { |i| "name_#{i}"} }
  email { sequence(:email) { |i| "name-#{i}@example.com"} }
  password "PasswordDigest"
  password_confirmation "PasswordDigest"
end
