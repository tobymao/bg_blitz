require_relative 'base'

module Views
  class SafeHtml < Base
    needs :raw

    def content
        rawtext Sanitize.fragment(raw, Sanitize::Config::RELAXED)
    end
  end
end
