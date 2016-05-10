require './views/base'

module Views
  class Audio < Base
    needs :file

    def content
      s = inline 'text-align' => 'left'

      div style: s do
        url = file.url

        audio style: 'width: 100%', controls: '', preload: 'none' do
          source src: url, type: file.mime_type
          text 'Your browser does not support the audio element.'
        end

        ds = inline(
          'text-align' => 'right',
          'margin-top' => '0.5em',
          'font-size' => '12px',
        )

        div style: ds  do
          a 'Download', href: url, style: "color:#{BGB_GRAY}"
        end
      end
    end
  end
end
