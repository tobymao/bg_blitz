require_relative 'base'

module Views
  class Banner < Base
    Icon = Struct.new :klass, :url, :name, :hidden

    SPRITE_URL = '/images/icon_sprites.jpg'

    ICONS = [
      Icon.new('rss', 'www.boardgameblitz.com', 'RSS'),
      Icon.new('facebook', 'https://www.facebook.com/BGBlitz', 'Facebook'),
      Icon.new('twitter', 'https://twitter.com/bgameblitz', 'Twitter'),
      Icon.new('google', 'https://google.com', 'Google', true),
      Icon.new('youtube', 'https://www.youtube.com/channel/UC-zQPrSCinOtta_INepZo_A', 'YouTube'),
      Icon.new('itunes', 'www.apple.com', 'iTunes'),
      Icon.new('bgg', 'https://boardgamegeek.com/guild/2581', 'BGG Guild'),
    ]

    def content
      div style: 'position:relative' do
        render_style

        a href: '/' do
          div class: 'banner'
        end

        ul class: 'icons' do
          ICONS.each do |data|
            next if data.hidden
            li class: "icon #{data.klass}" do
              a href: data.url, tooltip: data.name
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

    def icons_css icons, x, y, step
      value = 0

      icons.each_with_object(String.new) do |icon, css|
        css << <<~CSS
          .icon.#{icon.klass} { background: url(#{SPRITE_URL}) #{value}px #{x}px; }
          .icon.#{icon.klass} a:hover { background: url(#{SPRITE_URL}) #{value}px #{y}px; }
        CSS

        value -= step
      end
    end
  end
end
