require_relative 'base'

module Views
  class Banner < Base
    SPRITE_URL = '/images/icon_sprites.jpg'

    ICONS_DATA = [
      ['rss', 'www.boardgameblitz.com', 'RSS'],
      ['facebook', 'https://www.facebook.com/BGBlitz', 'Facebook'],
      ['twitter', 'https://twitter.com/bgameblitz', 'Twitter'],
      ['youtube', 'https://www.youtube.com/channel/UC-zQPrSCinOtta_INepZo_A', 'YouTube'],
      ['itunes', 'www.apple.com', 'iTunes'],
      ['bgg', 'https://boardgamegeek.com/guild/2581', 'BGG Guild'],
    ]

    ICONS = ICONS_DATA.map(&:first)

    def content
      div style: 'position:relative' do
        render_style

        a href: '/' do
          div class: 'banner'
        end

        ul class: 'icons' do
          ICONS_DATA.each do |data|
            li class: "icon #{data[0]}" do
              a href: data[1], tooltip: data[2]
            end
          end
        end
      end
    end
    static :content

    def render_style
      style <<~CSS
        .icons {
          right: 0;
          top: 0;
          position: absolute;
          list-style: none;
          height: 48px;
        }

        .icons .icon {
          display: inline-block;
          width: 30px;
          margin: 8px 1px 0px 1px;
        }

        .icons .icon a {
          height: 34px;
          display: block;
        }

        .icons .icon a:hover {
          position: relative;
        }

        .icons .icon a[tooltip]:hover:after {
          content: attr(tooltip);
          position: absolute;
          left: 0;
          top: 100%;
          font-size: 75%;
          padding: .5em .5em;
          background-color: white;
          color: #{BGB_PURPLE};
        }

        #{icons_css ICONS, -389, -423, 30}

        .banner {
          background-image: url(/images/bgb_logo_m.png);
          height: 50px;
          width: 100px;
        }

        @media only screen and (min-width: #{MOBILE_W}) {
          .banner {
            background-image: url(/images/bgb_logo_t.gif);
            width: 300px;
          }
        }

        @media only screen and (min-width: #{TABLET_W}) {
          .banner {
            background-image: url(/images/bgb_logo.png);
            width: 500px;
            margin: 0;
          }

          .icons .icon {
            width: 42px;
            margin: 0 2px 0 2px;
          }

          .icons .icon a { height: 48px; }

          #{icons_css ICONS, 0, -48, 43}
        }
      CSS
    end

    private
    def icons_css icons, x, y, step
      value = 0

      icons.each_with_object(String.new) do |name, css|
        css << <<~CSS
          .icon.#{name} { background: url(#{SPRITE_URL}) #{value}px #{x}px; }
          .icon.#{name} a:hover { background: url(#{SPRITE_URL}) #{value}px #{y}px; }
        CSS

        value -= step
      end
    end
  end
end
