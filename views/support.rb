require './views/page'

module Views
  class Support < Page
    SUPPORTERS = [
      'Adam Brocker',
      'Adrienne Dong',
      'Andrew Wilson',
      'bac68',
      'Barbara',
      'Ben Cook',
      "Ben O'Steen",
      'Board Game Barrage',
      'Brian Ashmore',
      'Catherine Wiener',
      'Charles Albrecht',
      'Charles Beauvais',
      'Chris Ferejohn',
      'Chris Imershein',
      'Chris Sasaki',
      'Chris Zebley',
      'Clay Crucible Games',
      'David Briel',
      'Dave Refici (@FrozenHoHos)',
      'Drew Hicks',
      'Eric & Amber Davila',
      'Evan Schmalz',
      'Flip the Table',
      'Geoff Mathews',
      'George Stankow',
      'Graham Glaser',
      'Greg Dickson',
      'Harley Winfrey',
      'Hilmar Hallbjörnsson',
      'Jae Malloy',
      'Jayson Smith',
      'Jen E',
      'Jenn B',
      'Jessica Barnes',
      'Jim K',
      'Joe C',
      'John Munsch',
      'Jon Paul',
      'Joseph Orso',
      'Josh Laison',
      'Joshua Lamkin',
      'Joshua Lee',
      'Joshua Starr',
      'Justin Difazzio',
      'Karen Cleveland',
      'Katrina Baker',
      'Kayla Nimis',
      'Keith Jones',
      'Kent Parker',
      'Kevin Russ',
      'Lindsay Grossmann',
      'Luyi Stork',
      'Mark Cruzan-Rea',
      'MaryBeth Breslin',
      'Marylou Holly',
      'Matt Maurice',
      'Matthew Jameson',
      'Matthew Young',
      'Merely Rachel',
      'Micah Liebert',
      'Miguel Manansala',
      'Nicholas Baker',
      'Olivia Lothary',
      'Pamela Wagner',
      'Rattlebox Games',
      'Ray Taylor',
      'Richard Fry',
      'Rosco Schock',
      'Scott',
      'Spencer Hopkins',
      'Terrence',
      'Trey Radu-Blackburn',
      "What's Eric Playing",
      'William Carrigan',
      'Winter Blair',
      'Xoe Allred',
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

