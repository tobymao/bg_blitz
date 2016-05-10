require './views/page'

module Views
  class Contact < Page
    def render_main

      s = inline(
        'margin' => '2em 0 2em 0',
        'line-height' => '1.5em',
        'text-align' => 'center',
      )

      ls = inline(
        'text-decoration' => 'none',
        'color' => BGB_PURPLE,
        'font-weight' => 'bold',
      )

      div style: s do
        h1 'Contact Us'
        text 'Email: '
        a 'boardgameblitz@gmail.com', href: 'mailto:boardgameblitz@gmail.com', style: ls
        br
        text 'Twitter: '
        a '@bgameblitz', href: 'https://twitter.com/bgameblitz', style: ls, target: 'blank'
        br
        text 'Facebook: '
        a 'BGBlitz', href: 'https://www.facebook.com/BGBlitz/', style: ls, target: 'blank'
        br
        text 'BoardGameGeek Guild: '
        a 'Board Game Blitz', href: 'https://www.boardgamegeek.com/guild/2581', style: ls, target: 'blank'
      end
    end
  end
end
