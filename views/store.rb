require './views/store'

module Views
  class Store < Page
    def render_main
      container_style = inline(
        margin: '2em 0 2em 0',
        line_height: '1.5em',
        text_align: 'center',
      )

      div style: container_style do
        h1 'T-Shirts from Analog Gamer'

        div style: inline(margin: '20px 0 20px 0', line_height: '1.3em', text_align: 'justify') do
          p do
            text 'We have partnered with '
            a 'Analog Gamer', href: 'https://analoggamer.com'
            text ' to make Board Game Blitz shirts.'
            text " A portion of the proceeds from shirt sales goes directly to us, so by purchasing one you'll look great AND be supporting our show directly!"
          end
        end

        div style: inline(max_width: '1024px', margin: '0 auto') do
          store_image '/images/shirt_logo.jpg'
          store_image '/images/shirt_pizza.jpg'
        end

      end
    end

    def page_title
      'Store'
    end

    def store_image url
      a href: 'https://analoggamer.com/collections/boardgameblitz' do
        img src: url, style: inline(width: '45%', min_width: '320px', margin: '5px')
      end
    end

  end
end
