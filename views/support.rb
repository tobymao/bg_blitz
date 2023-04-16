require './views/page'

module Views
  class Support < Page
    def render_main
      div style: default_container_style(text_align: 'center') do
        h1 'Support Us'

        a href: 'https://ko-fi.com/boardgameblitz', target: '_blank' do
          img src: 'https://storage.ko-fi.com/cdn/brandasset/kofi_s_tag_white.png', style: inline(height: '100px')
        end

        div style: inline(margin: '10px') do
          text 'Check out our '

          a href: 'https://www.redbubble.com/people/boardgameblitz/shop', target: '_blank' do
            text 'merchandise on Redbubble!'
          end
        end
      end
    end

    def page_title
      'Support Us'
    end

  end
end

