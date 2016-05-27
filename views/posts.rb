require './views/page'

module Views
  class Posts < Page
    needs :posts
    needs :items
    needs :limit

    def render_main
      container_style = inline(
        text_align: 'center',
        max_width: MOBILE_W,
        margin: '0 auto',
      )

      item_hash = items.each_with_object({}) do |item, hash|
        hash[item.id] = item
      end

      div style: container_style do
        posts.take(limit).each do |p|
          widget Views::Post, post: p, item_hash: item_hash
        end
      end
    end

    def render_footer
      widget Pager, more: posts.size > limit
      super
    end

  end
end
