require_relative '../page'

module Views
  module Admin
    class Page < Views::Page
      ADMIN_LINKS = [
        ['Posts', '/admin/posts'],
        ['Videos', '/admin/videos'],
        ['Podcasts', '/admin/podcasts'],
      ].freeze

      def render_head
        title 'Board Game Blitz Admin'
      end

      def render_nav
        widget Nav.new(links: ADMIN_LINKS)
      end
    end
  end
end
