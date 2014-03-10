module CommentsHelper
  def comment_link(comment)
    idea_path(comment.idea)
  end
  
  def comment_title(comment)
    comment.idea.title
  end
end
