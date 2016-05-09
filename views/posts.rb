require './views/page'

module Views
  class Posts < Page
    needs :posts
    needs :items

    def render_main
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

  end
end
