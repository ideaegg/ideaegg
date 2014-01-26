class AddLikesCountToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :likes_count, :integer
  end
end
