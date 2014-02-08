Fabricator(:comment) do
  content { sequence(:content ) { |i| "content-#{i}"} }
  user
  idea
end
