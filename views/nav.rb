require './views/base'

module Views
  class Nav < Base
    needs :links

    def content
      div style: inline('background' => BGB_PURPLE) do
        render_style

        # allows mobile devices to close the hover menu
        script <<~JS
          (function(l){var i,s={touchend:function(){}};for(i in s)l.addEventListener(i,s)})(document);
        JS

        div class: 'bgb_container' do
          div style: inline('text-align' => 'center') do
            links.each do |title, value|
              if value.is_a?(String)
                a title, href: value, class: 'nav_link'
              else
                div class: 'nav_link', onclick: '' do
                  text title
                  ul do
                    value.each { |t, v| a t, href: v, class: 'nav_link' }
                  end
                end
              end
            end
          end
        end

      end
    end

    def render_style
      style <<~CSS
        .nav_link {
          display: inline-block;
          line-height: 2em;
          margin: 0;
          color: white;
          text-decoration: none;
          text-transform: uppercase;
          width: 100px;
          -webkit-transition: all 0.2s;
          transition: all 0.2s;
          cursor: pointer;
        }

        .nav_link ul {
          position: absolute;
          margin: 0;
          visibility: hidden;
          z-index: 999;
        }

        .nav_link:hover {
          background: white;
          color: #{BGB_PURPLE};
        }

        .nav_link:hover > ul {
          visibility: visible;
        }

        ul .nav_link {
          display: block;
          background: #{BGB_PURPLE};
        }

        @media only screen and (min-width: #{MOBILE_W}) {
          .nav_link { width: 100px; }
        }

        @media only screen and (min-width: #{TABLET_W}) {
          .nav_link { width: 120px; }
        }
      CSS
    end
    static :render_style
  end
end
