require './views/base'

module Views
  class Page < Base
    DEFAULT_LINKS = [
      ['Home', '/'],
      ['Podcasts', '/podcasts'],
      ['Videos', '/videos'],
      ['Blog', '/blog'],
      ['About Us', '/about'],
      ['Contact', '/contact'],
    ].freeze

    def content
      html do
        head do
          link rel: 'stylesheet', type: 'text/css', href: 'https://fonts.googleapis.com/css?family=Open+Sans'
          link rel: 'stylesheet', type: 'text/css', href: '/vendor/reset.min.css'
          link rel: 'shortcut icon', type: 'image/png', href: '/images/favicon.ico'
          render_head
          render_style
          meta name: 'viewport', content: 'width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0'
          meta name: 'apple-mobile-web-app-capable', content: 'yes'
        end

        div style: inline(min_height: '95%') do
          div class: 'bgb_container' do
            render_banner
          end

          render_nav

          div class: 'bgb_container' do
            render_main
          end
        end

        render_footer
      end
    end

    def render_head
      title 'Board Game Blitz'
    end

    def render_style
      style <<~CSS
        body {
          font-family: 'Open Sans';
          width: 100%;
        }

        h1 {
          font-size: 2em;
          margin-bottom: 0.3em;
          line-height: 1em;
        }

        h2 {
          font-weight: bold ;
          font-size: 0.8em;
          margin-bottom: 1em;
        }

        .bgb_container {
          position: relative;
          padding: 0 5% 0 5%;
          margin: 0 auto;
          text-align: justify;
          max-width: #{MAX_W};
        }

        .icon {
          display: inline-block;
          width: 30px;
          margin: 8px 1px 0px 1px;
        }

        .icon a {
          height: 34px;
          display: block;
        }

        .icon a:hover {
          position: relative;
        }

        .icon a[tooltip]:hover:after {
          content: attr(tooltip);
          position: absolute;
          left: 0;
          top: 100%;
          font-size: 75%;
          padding: .5em .5em;
          background-color: white;
          color: #{Base::BGB_PURPLE};
          z-index: 999;
        }
      CSS
    end
    static :render_style

    def render_banner
      widget Banner
    end

    def render_nav
      widget Nav.new(links: DEFAULT_LINKS)
    end

    def render_main
      text 'This page intentionally left blank.'
    end

    def render_footer
      footer_style = inline(
        bottom: '0',
        color: BGB_PURPLE,
        font_size: '80%',
        text_align: 'center',
      )

      div style: footer_style do
        rawtext '&copy; Board Game Blitz 2016.'

        ls = inline(
          margin: '0.5em',
          text_decoration: 'none',
          color: BGB_PURPLE,
        )

        div do
          a 'About', href: '/about', style: ls
          a 'Contact', href: '/contact', style: ls
          a 'Podcasts', href: '/podcasts', style: ls
          a 'Videos', href: '/videos', style: ls
        end
      end
    end
  end
end
