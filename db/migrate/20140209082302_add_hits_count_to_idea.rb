class AddHitsCountToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :hits_count, :integer, default: 0
  end
end
