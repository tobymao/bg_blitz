require './views/base'

module Views
  class Audio < Base
    needs :file

    def content
      div style: inline(text_align: 'left') do
        url = file.url

        audio style: inline(width: '100%'), controls: '', preload: 'none' do
          source src: url, type: file.mime_type
          text 'Your browser does not support the audio element.'
        end

        download_style = inline(
          text_align: 'right',
          margin_top: '0.5em',
          font_size: '12px',
        )

        link_style = inline(
          color: BGB_GRAY,
          font_weight: 'normal',
        )

        div style: download_style  do
          a 'Download', href: url, style: link_style
        end
      end
    end
  end
end
