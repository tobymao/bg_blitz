require './views/base'

module Views
  class Page < Base
    needs page_title: nil

    DEFAULT_LINKS = [
      ['Home', '/'],
      ['Content ▾', [['Podcasts', '/podcasts'], ['Videos', '/videos'], ['Blog', '/blog']]],
      ['About', '/about'],
      ['Support Us', '/support'],
      ['Blitz Con', '/con'],
    ].freeze

    def content
      html do
        head do
          link rel: 'stylesheet', type: 'text/css', href: 'https://fonts.googleapis.com/css?family=Open+Sans:400,400italic,700'
          link rel: 'stylesheet', type: 'text/css', href: '/vendor/reset.min.css'
          link rel: 'shortcut icon', type: 'image/png', href: '/images/favicon.ico'
          render_head
          render_style
          render_analytics
          meta name: 'viewport', content: 'width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0'
          meta name: 'apple-mobile-web-app-capable', content: 'yes'
          meta charset: 'UTF-8'
        end

        div style: inline(min_height: '95%') do
          div class: 'bgb_container' do
            render_banner
          end

          render_nav

          div class: 'bgb_container main' do
            render_main
          end
        end

        render_footer
      end
    end

    def render_head
      if page_title
        title "#{page_title} | Board Game Blitz"
      else
        title 'Board Game Blitz'
        meta name: 'description', content: 'Board Game Blitz is a bi-weekly podcast and video series about modern board games and card games hosted by Ambie, Cassadi, and Crystal.'
      end
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
          font-weight: bold;
          font-size: 0.8em;
          margin-bottom: 0.3em;
        }

        b { font-weight: bold; }

        i { font-style: italic; }

        ul {
          list-style-type: disc;
          list-style-position: inside;
          margin-left: 15px;
        }

        .bgb_container {
          position: relative;
          padding: 0 5% 0 5%;
          margin: 0 auto;
          text-align: justify;
          max-width: #{MAX_W};
        }

        .bgb_container.main { font-size: 0.9em; }

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

        .main .icon a {
          font-weight: normal;
        }

        .main img {
          max-width: 100%;
        }

        .main a {
          text-decoration: none;
          font-weight: bold;
          color: #{BGB_PURPLE};
        }
      CSS
    end
    static :render_style

    def render_analytics
      script <<~JS
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
          (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
        ga('create', 'UA-78138575-1', 'auto');
        ga('send', 'pageview');
      JS
    end
    static :render_analytics

    def render_banner
      widget Banner
    end

    def render_nav
      widget Nav, links: DEFAULT_LINKS
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

        div style: inline(margin: '5px 0 8px 0') do
          a 'Podcasts', href: '/podcasts', style: ls
          a 'Videos', href: '/videos', style: ls
          a 'Blog', href: '/blog', style: ls
          a 'About', href: '/about', style: ls
          a 'Support Us', href: '/support', style: ls
          a 'Blitz Con', href: '/con', style: ls
          a 'Archives', href: '/archives', style: ls
        end
      end
    end
  end
end
