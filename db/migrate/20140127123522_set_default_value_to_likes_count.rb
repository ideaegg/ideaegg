class SetDefaultValueToLikesCount < ActiveRecord::Migration
  def up
    change_column :users, :likes_count, :integer, default: 0
    change_column :ideas, :likes_count, :integer, default: 0

    Idea.where(likes_count: nil).update_all(likes_count: 0)
    User.where(likes_count: nil).update_all(likes_count: 0)
  end
  def down
  end
end
