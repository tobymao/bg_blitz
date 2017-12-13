require './views/page'

module Views
  class Con < Page
    def render_main
      div style: default_container_style do
        img src: '/images/blitz_con.jpg', style: inline(width: '100%', min_width: '320px', margin: '5px')

        p style: inline(margin: '20px 0', text_align: 'justify') do
          text 'Join us for our second year of Blitz Con! Blitz Con is a small convention in the San Francisco Bay Area geared towards open gaming. We encourage everybody to bring their own games, but we are working on growing a small '
          a 'library', href: 'https://boardgamegeek.com/collection/user/blitzcon'
          text '.'
        end

        p do
          text 'Check out the '
          a 'Facebook Page', href: 'https://www.facebook.com/BoardGameBlitzCon/'
          text ' for updates.'
        end

        p do
          text 'Questions? Email us at '
          a 'boardgameblitzcon@gmail.com', href: 'mailto:boardgameblitzcon@gmail.com'
        end

        div do
          widget Box, name: 'TICKETS', style: { background_color: BGB_PURPLE }

          p do
            text 'Tickets are on sale through '
            a 'Eventbrite.', href: 'https://www.eventbrite.com/e/board-game-blitz-con-2018-tickets-35101438347?aff=moreinfo'
          end
        end

        div do
          widget Box, name: 'HOTEL', style: { background_color: BGB_PURPLE }

          p { a 'Hyatt Regency SFO', href: 'https://sanfranciscoairport.regency.hyatt.com/en/hotel/home.html' }
          p { text '1333 Old Bayshore Hwy' }
          p { text 'Burlingame, CA 94010' }
          br
          p { a 'Hotel block reservations.', href: 'https://aws.passkey.com/event/49232279/owner/4566/landing?gtid=ddfcfaac7d1c08f2abb050e9f3b521a6' }
        end

        div do
          widget Box, name: 'SPONSORS', style: { background_color: BGB_PURPLE }

          p { text "We're currently talking to sponsors to add games for prizes and our growing library." }
          br
          p { text 'Thanks to our generous sponsors!' }

          sponsor 'http://home.gamekastle.com/', '/images/con/Game_Kastle.png'
          sponsor 'https://victory-point-cafe.myshopify.com/', '/images/con/Victory_Point_Cafe.jpg'
          sponsor 'https://www.meeplerealty.com/', '/images/con/Meeple_Realty.png'
          sponsor 'https://www.level99games.com/', '/images/con/Level_99.png'
          sponsor 'https://www.gamesofberkeley.com/', '/images/con/Games_of_Berkeley.png'
          sponsor 'http://spielpro.com/', '/images/con/SpielPro.png'
          sponsor 'https://www.capstone-games.com/', '/images/con/Capstone_Games.png'
        end

        div do
          widget Box, name: 'Previous', style: { background_color: BGB_PURPLE }

          p do
            text "Check out last year's"
            a ' convention report!', href: 'http://www.boardgameblitz.com/posts/47/blitz-con-2017-recap'
          end
        end
      end
    end

    def sponsor site_link, image_path
      div style: inline(margin: '10px', display: 'inline-block') do
        a(href: site_link) { img src: image_path }
      end
    end

    def page_title
      'Blitz Con'
    end

  end
end
