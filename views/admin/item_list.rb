require './views/base'

module Views
  module Admin
    class ItemList < Views::Base
      needs :items
      needs :path

      def content
        item_style = inline margin: '0 5px 0 5px'
        form_style = inline display: 'inline-block', margin_left: '5px'

        h1 'Previous'

        ul do
          items.each do |item|
            li do
              span item.id, style: item_style
              span item.title, style: item_style
              span item.pp_created_at, style: item_style

              url = "#{path}/#{item.id}"
              a 'edit', href: url, style: item_style

              form action: "#{url}/delete", method: 'post', onsubmit: submit_js, style: form_style do
                rawtext csrf_tag
                input type: 'submit', value: 'delete'
              end
            end
          end
        end
      end

      def submit_js
        <<~JS
          return confirm('Are you sure you want to delete this?');
        JS
      end

    end
  end
end
