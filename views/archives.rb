require './views/page'

module Views
  class Archives < Page
    needs :posts

    def render_main
      return if posts.empty?

      div style: inline(margin: '5px') do
        last = posts.first.published_at

        render_date posts.first

        posts.each do |post|
          current = post.published_at
          render_date post if current.month != last.month || current.year != last.year
          last = current

          div style: inline(margin_bottom: '10px') do
            a post.title, href: post.path
          end
        end
      end
    end

    def render_date post
      h1 post.published_at.strftime '%B %Y'
    end

  end
end
