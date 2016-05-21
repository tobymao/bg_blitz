require './views/base'
require './views/icons'

module Views
  class Banner < Base
    def content
      render_style

      div style: inline(position: 'relative') do
        a href: '/' do
          div class: 'banner'
        end

        ul class: 'nav_icons' do
          Icons::ICONS.each do |data|
            next if data.hidden
            li class: "icon #{data.klass} nav_icon" do
              a href: data.url, tooltip: data.name
            end
          end
        end
      end
    end
    static :content

    def render_style
      style <<~CSS
        .banner {
          background-image: url(/images/bgb_logo_m.png);
          height: 50px;
          width: 100px;
        }

        .nav_icons {
          right: 0;
          top: 0;
          position: absolute;
          list-style: none;
          height: 48px;
        }

        #{Icons.icons_css 'nav_icon', Icons::ICONS, -389, -423, 30}

        @media only screen and (min-width: #{Base::MOBILE_W}) {
          .banner {
            background-image: url(/images/bgb_logo_t.gif);
            width: 300px;
          }
        }

        @media only screen and (min-width: #{Base::TABLET_W}) {
          .banner {
            background-image: url(/images/bgb_logo.png);
            width: 500px;
            margin: 0;
          }

          .nav_icons .icon {
            width: 42px;
            margin: 0 2px 0 2px;
          }

          .nav_icons .icon a { height: 48px; }

          #{Icons.icons_css 'nav_icon', Icons::ICONS, 0, -48, 43}
        }
      CSS
    end

  end
end
