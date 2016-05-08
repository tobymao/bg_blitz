require_relative 'page'

module Views
  class Podcasts < Page
    needs :posts

    def render_main
      posts.each do |post|
      end
    end
  end
end
