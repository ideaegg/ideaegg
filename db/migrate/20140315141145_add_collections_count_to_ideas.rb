class AddCollectionsCountToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :collections_count, :integer
  end
end
