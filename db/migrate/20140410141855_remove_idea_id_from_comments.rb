class RemoveIdeaIdFromComments < ActiveRecord::Migration
  def change
    Comment.where(commentable_type: nil).update_all(commentable_type: 'Idea')
    Comment.where(commentable_id: nil).update_all("commentable_id = idea_id")
    
    remove_column :comments, :idea_id, :integer
  end
end
