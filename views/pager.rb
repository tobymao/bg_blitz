require './views/base'

module Views
  class Pager < Base
    needs more: true

    def content
      page = (params['page'] || 1).to_i

      page_style = inline text_align: 'center', margin_bottom: '1em'

      div style: page_style do
        link_style = inline color: BGB_GRAY, margin_right: '1em'
        path = current_path + '?page='
        a 'Prev', href: path + "#{page - 1}", style: link_style if page > 1
        a 'Next', href: path + "#{page + 1}", style: link_style if more
      end
    end
  end
end
