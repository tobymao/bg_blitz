require './views/base'

module Views
  class Pager < Base
    def content
      page = (params['page'] || 1).to_i

      page_style = inline 'text-align' => 'center', 'margin-bottom' => '1em'

      div style: page_style do
        link_style = inline 'color' => BGB_GRAY, 'margin-right' => '1em'
        path = current_path + '?page='
        a 'Prev', href: path + "#{page - 1}", style: link_style if page > 1
        a 'Next', href: path + "#{page + 1}", style: link_style
      end
    end
  end
end
