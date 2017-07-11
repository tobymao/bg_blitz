require './views/base'

module Views
  class Box < Base
    needs style: {}
    needs :name

    DEFAULT_STYLE = {
      display: 'inline-block',
      color: 'white',
      width: '7em',
      font_size: '150%',
      margin: '.5em 0 .5em 0',
      text_transform: 'uppercase',
      text_align: 'center',
      vertical_align: 'top',
      padding: '.2em 0 .2em 0',
      background_clor: 'BGB_BLUE',
    }.freeze

    def content
      box_style = inline(DEFAULT_STYLE.merge(style))

      div style: box_style do
        text name
      end
    end

  end
end
