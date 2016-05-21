module Views
  class Base < Fortitude::Widget
    BGB_BLUE   = '#11a3d3'
    BGB_PINK   = '#ea64fa'
    BGB_PURPLE = '#9664fa'
    BGB_GRAY   = '#0f0f0f'

    TABLET_W = '1000px'
    MOBILE_W = '600px'
    MAX_W    = '950px'

    doctype :html5

    def self.csrf_tag= tag
      @@csrf_tag = tag
    end

    def csrf_tag
      rawtext @@csrf_tag
    end

    def self.current_path= path
      @@current_path= path
    end

    def current_path
      @@current_path
    end

    def self.params= params
      @@params= params
    end

    def params
      @@params
    end

    def self.inline hash
      array = hash.map do |k, v|
        "#{k.to_s.gsub '_', '-'}:#{v}"
      end

      array.join(';').freeze
    end

    def inline hash
      self.class.inline hash
    end
  end
end
