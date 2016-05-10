require './views/admin/page'

module Views
  module Admin
    class Items < Admin::Page
      needs :item
      needs :items

      PATH = '/admin/items'

      def render_main
        h1 'Upload File'

        render_new
        widget ItemList.new items: items, path: PATH
      end

      def render_new
        url = String.new PATH
        url << "/#{item.id}" if item

        form id: 'form', action: url, method: 'post', enctype: 'multipart/form-data' do
          csrf_tag
          input type: 'text', name: 'title', placeholder: 'Title', value: item&.title
          br
          text item.file.original_filename if item&.file
          br
          input type: 'file', name: 'file'
          br
          input type: 'text', name: 'external_url', placeholder: 'Embed Url', value: item&.external_url
          br
          input type: 'submit'
        end
      end
    end
  end
end
