require './views/page'

module Views
  class Support < Page
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
      end
    end

    def page_title
      'Support Us'
    end

  end
end
