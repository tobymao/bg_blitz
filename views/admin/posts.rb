module Views
  module Admin
    class Posts < Admin::Page
      needs :post
      needs :posts

      def render_main
        render_new
        render_all
      end

      def render_head
        super
        link rel: 'stylesheet', type: 'text/css', href: '/vendor/quill.snow.css'
        script src: '/vendor/quill.min.js'
      end

      def render_new
        url = String.new('/admin/posts')
        url << "/#{post.id}" if post

        form action: url, method: 'post', onsubmit: 'BGBPosts.onSubmit(event)' do
          rawtext csrf_tag

          div id: 'toolbar' do
            select title: 'Text Alignment', class: 'ql-align' do
              option value: 'left', selected: true
              option value: 'center'
              option value: 'right'
              option value: 'justify'
            end

            button title: 'Bold', class: 'ql-format-button ql-bold'
            button title: 'Italic', class: 'ql-format-button ql-italic'
            button title: 'Underline', class: 'ql-format-button ql-underline'
            button title: 'Strikethrough', class:'ql-format-button ql-strike'
            button title: 'Link', class: 'ql-format-button ql-link'
            button title: 'Image', class: 'ql-format-button ql-image'
            button title: 'Bullet', class: 'ql-format-button ql-bullet'
            button title: 'List', class: 'ql-format-button ql-list'
          end

          input type: 'text', name: 'title', placeholder: 'Post Title', value: post&.title
          input type: 'hidden', name: 'text', id: 'text_field'
          input type: 'hidden', name: 'id', value: post&.id

          div(id: 'editor') { rawtext post&.text }

          input type: 'submit'

          script <<-JS
            var BGBPosts = {
              editor: new Quill('#editor', {
                modules: {
                  'toolbar': '#toolbar',
                  'link-tooltip': true,
                  'image-tooltip': true,
                },
                styles: false,
                theme: 'snow',
              }),

              onSubmit: function(event) {
                event.preventDefault();
                var textField = document.getElementById('text_field');
                textField.value = this.editor.getHTML();
                event.target.submit();
              },
            };
          JS
        end
      end

      PP_STYLE = inline 'margin' => '0 5px 0 5px'

      def render_all
        div 'Previous Posts'

        ul do
          posts.each do |p|
            li do
              span p.id, style: PP_STYLE
              span p.title, style: PP_STYLE
              span p.created_at, style: PP_STYLE
              a 'edit', href: "/admin/posts?id=#{p.id}", style: PP_STYLE
            end
          end
        end
      end
    end
  end
end
