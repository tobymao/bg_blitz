require './views/page'

module Views
  class Contact < Page
    def render_main

      container_style = inline(
        margin: '2em 0 2em 0',
        line_height: '1.5em',
        text_align: 'center',
      )

      div style: container_style do
        h1 'Contact Us'
        text 'Email: '
        a 'boardgameblitz@gmail.com', href: 'mailto:boardgameblitz@gmail.com'
        br
        text 'Twitter: '
        a '@bgameblitz', href: 'https://twitter.com/bgameblitz', target: 'blank'
        br
        text 'Instagram: '
        a '@boardgameblitz', href: 'https://www.instagram.com/boardgameblitz/', target: 'blank'
        br
        text 'Facebook: '
        a 'BGBlitz', href: 'https://www.facebook.com/BGBlitz/', target: 'blank'
        br
        text 'BoardGameGeek Guild: '
        a 'Board Game Blitz', href: 'https://www.boardgamegeek.com/guild/2581', target: 'blank'
      end
    end

    def page_title
      'Contact'
    end

  end
end
