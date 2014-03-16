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
    return if idea.destroyed?

    like_label = if current_user && current_user.like?(idea)
                   link_to unlike_idea_path(idea), method: :delete do
                     fa_icon 'heart', text: 'Liked'
                   end
                 else
                   link_to like_idea_path(idea), method: :post do
                     fa_icon 'heart-o', text: 'Like'
                   end
                 end


    content_tag :li, raw(like_label)
  end

  def comment_tag(idea)
    return unless idea
    return if idea.comments.count.zero?

    content_tag :span, fa_icon('comments', text: idea.comments.count)
  end

  def share_tag
    html = %Q(
      <div class="jiathis_style_24x24">
        <a class="jiathis_button_tsina"></a>
	      <a class="jiathis_button_weixin"></a>
      </div>
      <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=1361540932468224" charset="utf-8"></script>
    )

    content_tag :div, raw(html)
  end
end
