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

      s = inline(
      'text-align' => 'center',
      'max-width' => MOBILE_W,
      'margin' => '0 auto',
      )

      item_hash = items.each_with_object({}) do |item, hash|
        hash[item.id] = item
      end

      div style: s do
        posts.each do |p|
          widget Views::Post.new post: p , item_hash: item_hash
        end
      end
    end

    def render_footer
      page = (params['page'] || 1).to_i

      s = inline 'text-align' => 'center', 'margin-bottom' => '1em'

      div style: s do
        ls = inline 'color' => BGB_GRAY, 'margin-right' => '1em'
        a 'Prev', href: current_path + "?page=#{page - 1}", style: ls if page > 1
        a 'Next', href: current_path + "?page=#{page + 1}", style: ls
      end

      super
    end

  end
end
