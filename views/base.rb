module Views
  class Base < Fortitude::Widget
    BGB_BLUE   = '#11a3d3'
    BGB_PINK   = '#ea64fa'
    BGB_PURPLE = '#9664fa'
    BGB_GRAY   = '#0f0f0f'

    TABLET_W = '1000px'
    MOBILE_W = '600px'
    MAX_W    = '950px'

    needs csrf_tag: ''
    needs request: {}

    doctype :html5

    def self.inline hash
      array = hash.map do |k, v|
        "#{k.to_s.gsub '_', '-'}:#{v}"
      end

      array.join(';').freeze
    end

    def inline hash
      self.class.inline hash
    end

    # override
    def widget w, hash = nil, &block
      hash ||= {}
      hash[:csrf_tag] ||= csrf_tag
      hash[:request] ||= request

      super w, hash, &block
    end

    def params
      request['params'] || {}
    end

    def current_path
      request['path'] || ''
    end
  end
end
