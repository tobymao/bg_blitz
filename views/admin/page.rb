require_relative '../page'

module Views
  module Admin
    class Page < Views::Page
      def render_nav
        div do
          nav_link 'Posts', ''
          nav_link 'Videos', ''
          nav_link 'Podcasts', ''
        end
      end
    end
  end
end
