class AddCollectionsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :collections_count, :integer
  end
end
