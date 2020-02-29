require './views/page'

module Views
  class Support < Page
    SUPPORTERS = [
      'Adam Reeve',
      'Adrienne Dong',
      'Alan Skinner',
      'Andrew Wilson',
      'bac68',
      'Barbara',
      'Ben Cook',
      "Ben O'Steen",
      'Big Tom Casual',
      'Brian Ashmore',
      'Brian Ganninger',
      'Catherine Wiener',
      'Charles Beauvais',
      'Chris Imershein',
      'Chris Mitchel',
      'Chris Sasaki',
      'Chris Zebley',
      'Clay Crucible Games',
      'Cory Cray',
      'Darth Grader',
      'David Campos',
      'David Briel',
      'Dave Krechevskoy',
      'Dave Refici (@FrozenHoHos)',
      'Drew Hicks',
      'Eric & Amber Davila',
      'Eric Glimme',
      'Eugene Meidinger',
      'Flip the Table',
      'Gary Franczyk',
      'George Campbell',
      'Greg Dickson',
      'Hammond Buckland',
      'Hilmar Hallbjörnsson',
      'Jae Malloy',
      'James Ewing',
      'Jen E',
      'Jerrett Watts',
      'Jesse Metcalf',
      'Jim K',
      'Joe C',
      'John Munsch',
      'Jonny Jimison',
      'Joseph Orso',
      'Joshua Lamkin',
      'Joshua Lee',
      'Joshua Neikirk',
      'Joshua Starr',
      'Karen Cleveland',
      'Katrina Baker',
      'Kayla Nimis',
      'Kevin Russ',
      'Lindsay Grossmann',
      'Luyi Stork',
      'Mark Cruzan-Rea',
      'Marylou Holly',
      'Mathilde Bruneau',
      'Matthew Jameson',
      'Matthew Young',
      'Merely Rachel',
      'Micah Liebert',
      'Michael McCallen',
      'Michelle English',
      'Miguel Manansala',
      'Mike Risley',
      'Mike Rudmann',
      'Nicholas Baker',
      'Pamela Wagner',
      'Patrick Hillier',
      'Paul McGowan',
      'Philippe Norel-Wilson',
      'Scott Vetter',
      'Rafael Cordero',
      'Rattlebox Games',
      'Richard Fry',
      'Rob Greanias',
      'Rosco Schock',
      'Sara Tedrick Parikh',
      'Scott',
      'Sean Koehn',
      'Spencer Hopkins',
      'Terrence',
      'Therese Monahan',
      'Toni Nummela',
      'Trevor Olsen',
      "What's Eric Playing",
      'William B',
      'William Carrigan',
      'Winter Blair',
    ].sort.freeze

    def render_main
      div style: default_container_style(text_align: 'center') do
        h1 'Support Us'

        a href: 'https://www.patreon.com/boardgameblitz', target: '_blank' do
          img src: '/images/patreon.png', style: inline(height: '45px')
        end

        div style: inline(margin: '10px') do
          text 'Check out our '

          a href: 'https://www.redbubble.com/people/boardgameblitz/shop', target: '_blank' do
            text 'merchandise on Redbubble!'
          end
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

