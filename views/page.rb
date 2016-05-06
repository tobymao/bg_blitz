require_relative 'base'
require_relative 'style'

module Views
  class Page < Base
    include Style

    needs :csrf_tag

    NAV_STYLE    = inline 'background' => BGB_PURPLE, 'text-align' => 'center'
    MAIN_STYLE   = inline 'text-align' => 'center'
    FOOTER_STYLE = inline 'text-align' => 'center'

    def content
      html do
        head do
          render_head
          meta name: 'viewport', content: 'width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0'
          meta name: 'apple-mobile-web-app-capable', content: 'yes'
        end

        div { render_banner }
        div(style: NAV_STYLE) { render_nav }
        div(style: MAIN_STYLE) { render_main }
        div(style: FOOTER_STYLE) { render_footer }
      end
    end

    def render_head
      title 'Board Game Blitz'
      link rel: 'stylesheet', type: 'text/css', href: 'https://fonts.googleapis.com/css?family=Open+Sans'
      link rel: 'stylesheet', type: 'text/css', href: '/vendor/reset.min.css'
      
      style <<~CSS
        body {
          font-family: 'Open Sans';
          width: 100%;
        }
      CSS
    end

    SPRITE_URL = '/images/icon_sprites.jpg'

    def render_banner
      style <<~CSS
        .banner {
          background-image: url(/images/bgb_logo_m.png);
          height: 50px;
          width: 100px;
        }

        @media only screen and (min-width: 768px) {
          .banner {
            background-image: url(/images/bgb_logo.png);
            height: 50px;
            width: 500px;
          }
        }
    
        .icons {
          right: 5px;
          top: 0;
          position: absolute;
          list-style: none;
          height: 48px;
        }

        .icons .icon {
          display: inline-block;
          width: 42px;
        }

        .icons .icon a {
           height: 48px;
           display: block;
        }

        .icon.rss { background: url(#{SPRITE_URL}) 0 0; }
        .icon.facebook { background: url(#{SPRITE_URL}) -43px 0; }
        .icon.twitter { background: url(#{SPRITE_URL}) -86px 0; }
        .icon.google { background: url(#{SPRITE_URL}) -129px 0; }
        .icon.youtube { background: url(#{SPRITE_URL}) -172px 0; }
        .icon.itunes { background: url(#{SPRITE_URL}) -215px 0; }
        .icon.bgg { background: url(#{SPRITE_URL}) -258px 0; }
      CSS
      
      div class: 'banner'

      ul class: 'icons' do
        icon 'rss', 'www.boardgameblitz.com'
        icon 'facebook', 'www.facebook.com'
        icon 'twitter', 'www.twitter.com'
        icon 'google', 'www.googleplus.com'
        icon 'youtube', 'www.youtube.com'
        icon 'itunes', 'www.apple.com'
        icon 'bgg', 'www.boardgamegeek.com'
      end
    end
    
    def icon name, url
      li(class: "icon #{name}") { a href: url }
    end

    def render_nav
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
          width: 25%;
          -webkit-transition: all 0.2s;
          transition: all 0.2s;
        }

        @media only screen and (min-width: 600px) {
          .nav_link { width: 20%; }
        }

        @media only screen and (min-width: 768px) {
          .nav_link { width: 8em; }
        }
      CSS
      
      nav_link 'Home', ''
      nav_link 'Podcasts', ''
      nav_link 'Videos', ''
      nav_link 'About Us', ''
      nav_link 'Sponsors', ''
      nav_link 'Contact', ''
    end
    
    def nav_link name, url
      a name, href: url, class: 'nav_link'
    end
    
    def render_main
      text 'This page intentionally left blank.'
    end

    def render_footer
      div 'Site map, contact, copyright. etc'
    end
  end
end
