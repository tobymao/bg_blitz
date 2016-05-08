require_relative '../base'

module Views
  module Admin
    class ItemList < Base
      needs :items
      needs :path

      def content
        is = inline 'margin' => '0 5px 0 5px'
        fs = inline 'display' => 'inline-block', 'margin-left' => '5px'

        h1 'Previous'

        ul do
          items.each do |item|
            li do
              span item.id, style: is
              span item.title, style: is
              span item.pp_created_at, style: is

              url = "#{path}/#{item.id}"
              a 'edit', href: url, style: is

              form action: "#{url}/delete", method: 'post', onsubmit: submit_js, style: fs do
                csrf_tag
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
