require './views/page'

module Views
  class Support < Page
    SUPPORTERS = [
      'Aaron Brown',
      'Adam Reeve',
      'Adrienne Dong',
      'Alan Skinner',
      'Andrew Wilson',
      'Becky Rolfe',
      "Ben O'Steen",
      'Bill Simoni',
      'Chris Mitchel',
      'Chris Sasaki',
      'Chris Toth',
      'Clay Crucible Games',
      'Dave Krechevskoy',
      'Eric & Amber Davila',
      'Erik Vasu-Sarver',
      'Flip the Table',
      'Gary Franczyk',
      'Hammond Buckland',
      'Jacob Shockcor',
      'Jesse Metcalf',
      'Jonny Jimison',
      'Joshua Lee',
      'Larry Nehring',
      'Mason Weaver',
      'Megan Bealmer',
      'Merely Rachel',
      'Micah Liebert',
      'Mike Risley',
      'Nicholas Baker',
      'Patrick Hillier',
      'Scott Vetter',
      'Rafael Cordero',
      'Rattlebox Games',
      'Ray Slakinski',
      'Richard Fry',
      'Robert Oswald',
      'Rodney Smith',
      'Voltaire Jayme',
      'Winter Blair',
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
