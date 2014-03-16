module CollectionsHelper
  def collect_tag(idea)
    return unless idea
    return if idea.collections_count.zero?

    if current_user && current_user.collected?(idea)
      content_tag :span, fa_icon('star', text: idea.collections_count)
    else
      content_tag :span, fa_icon('star-o', text: idea.collections_count)
    end
  end

  def collect_button(idea) 
    return unless idea

    collect_label = if current_user && current_user.collected?(idea)
                      link_to not_collect_idea_path(idea), method: :delete do
                        fa_icon 'star', text: 'collected'
                      end
                    else
                      link_to collect_idea_path(idea), method: :post do
                        fa_icon 'star-o', text: 'collect'
                      end
                    end

    content_tag :li, raw(collect_label)
  end
end
