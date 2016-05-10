require './views/base'

module Views
  class Youtube < Base
    needs :url

    def content
      div_style = inline(
        'position' => 'relative',
        'width' => '100%',
        'height' => '0',
        'padding-bottom' => '60%',
      )

      div style: div_style do
        frame_style = inline(
          'position' => 'absolute',
          'left' => '0',
          'top' => '0',
          'width' => '100%',
          'height' => '100%',
        )

        iframe style: frame_style, src: url
      end
    end
  end
end
