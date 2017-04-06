require './views/page'

module Views
  class Support < Page
    SUPPORTERS = [
      'Adrienne Dong',
      'Andrew Wilson',
      "Ben O'Steen",
      'Chris Mitchel',
      'Chris Sasaki',
      'Clay Crucible Games',
      'Eric & Amber Davila',
      'Flip the Table',
      'Gary Franczyk',
      'Jacob Shockcor',
      'Jonny Jimison',
      'Mason Weaver',
      'Megan Bealmer',
      'Merely Rachel',
      'Mike Risley',
      'Nicholas Baker',
      'Rafael Cordero',
      'Ray Slakinski',
      'Robert Oswald',
      'Voltaire Jayme',
    ].sort.freeze

    def render_main
      container_style = inline(
        margin: '2em 0 2em 0',
        line_height: '1.5em',
        text_align: 'center',
      )

      div style: container_style do
        h1 'Support Us'

        a href: 'https://www.patreon.com/boardgameblitz', target: '_blank' do
          img src: '/images/patreon.png', style: inline(height: '45px')
        end

        h1 style: inline(margin: '20px 0 20px 0', font_size: '25px') do
          text 'Thanks To Our Current Patrons'
        end

        SUPPORTERS.each do |name|
          div do
            text name
          end
        end
      end
    end

    def page_title
      'Support Us'
    end

  end
end
