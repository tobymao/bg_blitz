require_relative 'page'

module Views
  class Home < Page
    needs :posts

    def render_main
      posts.each do |p|
        widget Views::Post.new(post: p)
      end
    end
  end
end
