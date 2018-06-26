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
      'Ben Cook',
      "Ben O'Steen",
      'Bill Simoni',
      'Catherine Wiener',
      'Carmen Petruzzelli',
      'Charles Beauvais',
      'Chris Mitchel',
      'Christopher Nokleberg',
      'Chris Sasaki',
      'Chris Toth',
      'Clay Crucible Games',
      'Dave Krechevskoy',
      'Dave Refici (@FrozenHoHos)',
      'Eric & Amber Davila',
      'Erik Vasu-Sarver',
      'Flip the Table',
      'Gary Franczyk',
      'George Campbell',
      'Hammond Buckland',
      'J. Brandon Massengill',
      'James Fitzgerald',
      'Jerrett Watts',
      'Jesse Metcalf',
      'Joe C',
      'Joel Stout',
      'John du Bois',
      'John Munsch',
      'Jonny Jimison',
      'Joshua Lee',
      'Karen Cleveland',
      'Keith McRell',
      'Kevin Russ',
      'Lance Morgan',
      'Larry Nehring',
      'Lindsay Grossmann',
      'Luyi Stork',
      'Matthew Jameson',
      'Matthew Young',
      'Megan Bealmer',
      'Merely Rachel',
      'Micah Liebert',
      'Miguel Manansala',
      'Mike Risley',
      'Mike Rudmann',
      'Nathan Thompson',
      'Nicholas Baker',
      'Nicholas I Martinez',
      'Paul McGowan',
      'Scott Vetter',
      'Rachel Atkins',
      'Rafael Cordero',
      'Rattlebox Games',
      'Ray Slakinski',
      'Rebekah Harmon',
      'Richard Fry',
      'Robert Oswald',
      'Rodney Smith',
      'Sean Koehn',
      'Spencer Hopkins',
      'Voltaire Jayme',
      "What's Eric Playing",
      'William B',
      'Winter Blair',
    ].sort.freeze

    def render_main
      div style: default_container_style(text_align: 'center') do
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
