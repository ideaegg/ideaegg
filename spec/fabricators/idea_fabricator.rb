Fabricator(:idea) do
  title { sequence(:title) { |i| "title-#{i}"} }
  description { sequence(:description ) { |i| "description -#{i}"} }
  user
end
