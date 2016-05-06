module Views
  class Base < Fortitude::Widget
    doctype :html5

    def self.inline hash
      hash.map { |k, v| "#{k}:#{v}" }.join(';').freeze
    end

    def inline hash
      self.class.inline hash
    end
  end
end
