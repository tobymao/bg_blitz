require './views/page'

module Views
  class Posts < Page
    needs :posts
    needs :items

    def render_main
      s = inline 'text-align' => 'center'

      item_hash = items.each_with_object({}) do |item, hash|
        hash[item.id] = item
      end

      div style: s do
        posts.each do |p|
          div { widget Views::Post.new post: p , item_hash: item_hash }
        end
      end
    end

  end
end
