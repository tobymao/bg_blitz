require './views/page'

module Views
  class Support < Page
    SUPPORTERS = [
      'Adam Brocker',
      'Adam Reeve',
      'Adrienne Dong',
      'Alan Skinner',
      'Amos Cai',
      'Andrew Wilson',
      'Becky Rolfe',
      'Ben Cook',
      "Ben O'Steen",
      'Big Tom Casual',
      'Bill Simoni',
      'Brad Phillips',
      'Brian Ashmore',
      'Brian Blottie',
      'Brian Ganninger',
      'Catherine Wiener',
      'Carmen Petruzzelli',
      'Charles Beauvais',
      'Charles Leonard',
      'Chris Imershein',
      'Chris Mitchel',
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
      'Eugene Meidinger',
      'Evan Schans',
      'Flip the Table',
      'Gary Franczyk',
      'George Campbell',
      'Greg Dickson',
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
      'Joshua Lamkin',
      'Joshua Lee',
      'Joshua Neikirk',
      'Joshua Starr',
      'Karen Cleveland',
      'Katrina Baker',
      'Kayla Nimis',
      'Kellen Allen',
      'Kevin Russ',
      'Lance Morgan',
      'Lindsay Grossmann',
      'Luyi Stork',
      'Mark Cruzan-Rea',
      'Marylou Holly',
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
      'Rebekah Harmon',
      'Richard Fry',
      'Rob Greanias',
      'Rosco Schock',
      'Sean Koehn',
      'Spencer Hopkins',
      'Terrence',
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

