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
      'Brad Phillips',
      'Chris Mitchel',
      'Chris Sasaki',
      'Chris Toth',
      'Clay Crucible Games',
      'Dave Krechevskoy',
      'Dave Refici (@FrozenHoHos)',
      'Eric & Amber Davila',
      'Erik Vasu-Sarver',
      'Flip the Table',
      'Gary Franczyk',
      'Hammond Buckland',
      'J. Brandon Massengill',
      'Jacob Shockcor',
      'Jerrett Watts',
      'Jesse Metcalf',
      'John Munsch',
      'Jonny Jimison',
      'Joshua Lee',
      'Larry Nehring',
      'Mason Weaver',
      'Matthew Young',
      'Megan Bealmer',
      'Merely Rachel',
      'Micah Liebert',
      'Mike Risley',
      'Mike Rudmann',
      'Nicholas Baker',
      'Patrick Hillier',
      'Paul McGowan',
      'Scott Vetter',
      'Rafael Cordero',
      'Rattlebox Games',
      'Ray Slakinski',
      'Richard Fry',
      'Robert Oswald',
      'Rodney Smith',
      'Timothy Taufeek',
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
