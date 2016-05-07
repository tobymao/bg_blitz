require_relative 'page'

module Views
  class Home < Page
    needs :posts

    def render_main
      s = inline 'text-align' => 'center'

      div style: s do
        posts.each do |p|
          widget Views::Post.new(post: p)
          br
        end
      end
    end
  end
end
