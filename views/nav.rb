require_relative 'base'

module Views
  class Nav < Base
    needs :links

    NAV_STYLE = inline 'background' => BGB_PURPLE

    def content
      div style: NAV_STYLE do
        render_style

        div style: CONTAINER_STYLE do
          links.each do |link|
            a link[0], href: link[1], class: 'nav_link'
          end
        end
      end
    end

    def render_style
      style <<~CSS
        a.nav_link:hover {
          background: white;
          color: #{BGB_PURPLE};
        }

        .nav_link {
          display: inline-block;
          line-height: 2em;
          text-align: center;
          margin: 0;
          color: white;
          text-decoration: none;
          text-transform: uppercase;
          width: 35%;
          -webkit-transition: all 0.2s;
          transition: all 0.2s;
        }

        @media only screen and (min-width: #{MOBILE_W}) {
          .nav_link { width: 18%; }
        }

        @media only screen and (min-width: #{TABLET_W}) {
          .nav_link { width: 8em; }
        }
      CSS
    end
    static :render_style
  end
end
