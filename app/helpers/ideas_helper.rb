module IdeasHelper
  def like_tag(idea)
    return unless idea
    return if idea.likes_count.zero?

    if current_user && current_user.like?(idea)
      content_tag :span, fa_icon('heart', text: idea.likes_count)
    else
      content_tag :span, fa_icon('heart-o', text: idea.likes_count)
    end
  end

  def like_button(idea)
    return unless idea

    like_label = if current_user && current_user.like?(idea)
                   link_to unlike_idea_path(idea), method: :delete do
                     fa_icon 'heart', text: 'Liked'
                   end
                 else
                   link_to like_idea_path(idea), method: :post do
                     fa_icon 'heart-o', text: 'Like'
                   end
                 end

    like_label << content_tag(:span, idea.likes_count)

    content_tag :li, raw(like_label)
  end

  def comment_tag(idea)
    return unless idea
    return if idea.comments.count.zero?

    content_tag :span, fa_icon('comments', text: idea.comments.count)
  end
end
