require_relative 'base'

module Views
  class Audio < Base
    needs :file

    def content
      s = inline 'text-align' => 'left'

      div style: s do
        url = file.url

        audio controls: '', preload: 'none' do
          source src: url, type: file.mime_type
          text 'Your browser does not support the audio element.'
        end

        a 'Download', href: url
      end
    end
  end
end
