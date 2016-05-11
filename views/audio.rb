require './views/base'

module Views
  class Audio < Base
    needs :file

    def content
      container_style = inline 'text-align' => 'left'

      div style: container_style do
        url = file.url

        audio style: 'width: 100%', controls: '', preload: 'none' do
          source src: url, type: file.mime_type
          text 'Your browser does not support the audio element.'
        end

        download_style = inline(
          'text-align' => 'right',
          'margin-top' => '0.5em',
          'font-size' => '12px',
        )

        div style: download_style  do
          a 'Download', href: url, style: "color:#{BGB_GRAY}"
        end
      end
    end
  end
end
