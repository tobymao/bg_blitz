require './views/page'

module Views
  class Contact < Page
    def render_main

      container_style = inline(
        margin: '2em 0 2em 0',
        line_height: '1.5em',
        text_align: 'center',
      )

      link_style = inline(
        text_decoration: 'none',
        color: BGB_PURPLE,
        font_weight: 'bold',
      )

      div style: container_style do
        h1 'Contact Us'
        text 'Email: '
        a 'boardgameblitz@gmail.com', href: 'mailto:boardgameblitz@gmail.com', style: link_style
        br
        text 'Twitter: '
        a '@bgameblitz', href: 'https://twitter.com/bgameblitz', style: link_style, target: 'blank'
        br
        text 'Facebook: '
        a 'BGBlitz', href: 'https://www.facebook.com/BGBlitz/', style: link_style, target: 'blank'
        br
        text 'BoardGameGeek Guild: '
        a 'Board Game Blitz', href: 'https://www.boardgamegeek.com/guild/2581', style: link_style, target: 'blank'
      end
    end
  end
end
