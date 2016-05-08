module Views
  class Base < Fortitude::Widget
    BGB_BLUE   = '#11a3d3'
    BGB_PINK   = '#ea64fa'
    BGB_PURPLE = '#9664fa'

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

    def self.inline hash
      hash.map { |k, v| "#{k}:#{v}" }.join(';').freeze
    end

    def inline hash
      self.class.inline hash
    end
  end
end
