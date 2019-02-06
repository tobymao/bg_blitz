require './views/page'

module Views
  class Support < Page
    SUPPORTERS = [
      'Adam Reeve',
      'Adrienne Dong',
      'Alan Skinner',
      'Amos Cai',
      'Andrew Wilson',
      'Becky Rolfe',
      'Ben Cook',
      'Ben Gulick',
      "Ben O'Steen",
      'Big Tom Casual',
      'Bill Simoni',
      'Brian Ashmore',
      'Brian Blottie',
      'Brian Ganninger',
      'Catherine Wiener',
      'Carmen Petruzzelli',
      'Charles Beauvais',
      'Charles Leonard',
      'Chris Imershein',
      'Chris Mitchel',
      'Christopher Nokleberg',
      'Chris Sasaki',
      'Chris Toth',
      'Clay Crucible Games',
      'Cory Cray',
      'Darth Grader',
      'David Fair',
      'David Briel',
      'Dave Krechevskoy',
      'Dave Refici (@FrozenHoHos)',
      'Drew Hicks',
      'Eric & Amber Davila',
      'Eric Glimme',
      'Flip the Table',
      'Gary Franczyk',
      'George Campbell',
      'Greg Dickson',
      'Hilmar Hallbjörnsson',
      'J. Brandon Massengill',
      'Jake Bock',
      'James Fitzgerald',
      'Jen E',
      'Jerrett Watts',
      'Jesse Metcalf',
      'Jim K',
      'Joe C',
      'Joel Stout',
      'John Munsch',
      'Jonny Jimison',
      'Joshua Lamkin',
      'Joshua Lee',
      'Joshua Neikirk',
      'Karen Cleveland',
      'Katrina Baker',
      'Keith McRell',
      'Kevin Russ',
      'Lance Morgan',
      'Larry Nehring',
      'Lindsay Grossmann',
      'Luyi Stork',
      'Maria Ella Ampongan',
      'Mark Cruzan-Rea',
      'Matthew Jameson',
      'Matthew Young',
      'Merely Rachel',
      'Micah Liebert',
      'Michael McCallen',
      'Miguel Manansala',
      'Mike Risley',
      'Mike Rudmann',
      'Nicholas Baker',
      'Nicholas I Martinez',
      'Patrick Hillier',
      'Paul McGowan',
      'Philippe Norel-Wilson',
      'Scott Vetter',
      'Rachel Atkins',
      'Rafael Cordero',
      'Rattlebox Games',
      'Ray Slakinski',
      'Rebekah Harmon',
      'Richard Fry',
      'Rob Greanias',
      'Robert Oswald',
      'Rodney Smith',
      'Rosco Schock',
      'Sean Koehn',
      'Spencer Hopkins',
      'Terrence',
      'Trevor Olsen',
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

