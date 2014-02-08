class AddLikesCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :likes_count, :integer
  end
end
