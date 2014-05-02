module CommentsHelper
  def comment_link(comment)
    idea_path(comment.commentable)
  end
  
  def comment_title(comment)
    comment.commentable.title
  end
end
