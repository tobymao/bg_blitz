require './views/page'

module Views
  class Posts < Page
    needs :posts
    needs :items

    def render_main
      style <<~CSS
        .post div {
          margin-bottom: 1em;
        }
      CSS

      container_style = inline(
        text_align: 'center',
        max_width: MOBILE_W,
        margin: '0 auto',
      )

      item_hash = items.each_with_object({}) do |item, hash|
        hash[item.id] = item
      end

      div style: container_style do
        posts.each do |p|
          widget Views::Post.new post: p , item_hash: item_hash
        end
      end
    end

    def render_footer
      widget Pager
      super
    end

  end
end
