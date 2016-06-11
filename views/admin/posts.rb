require './views/admin/page'

module Views
  module Admin
    class Posts < Admin::Page
      needs :post
      needs :posts

      PATH = '/admin/posts'

      def render_head
        super
        link rel: 'stylesheet', type: 'text/css', href: '/vendor/quill.snow.css'
        script src: '/vendor/quill.min.js'
      end

      def render_main
        h1 'Posts'
        render_new
        widget ItemList, items: posts, path: PATH
        render_js
      end

      def render_new
        url = String.new PATH
        url << "/#{post.id}" if post

        form id: 'form', action: url, method: 'post', onsubmit: 'BGBPosts.onSubmit(event)' do
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

          input type: 'text', name: 'title', placeholder: 'Title', value: post&.title
          br

          textarea name: 'description', form: 'form', placeholder: 'Description'do
            text post&.description
          end
          br

          textarea name: 'tags', form: 'form', placeholder: 'Tags CSV' do
            if tags = post&.tags
              text tags.join ','
            else
              text 'Uncategorized'
            end
          end
          br

          select title: 'type', name: 'type', form: 'form' do
            ::Post.types.each do |type|
              option value: type, selected: post&.type == type do
                text type
              end
            end
          end
          br

          div do
            a 'Preview Post', href: "/posts/#{post.id}"
          end if post

          label do
            text 'Published'
            input type: 'checkbox', name: 'published', checked: post&.published
          end

          input type: 'hidden', name: 'text', id: 'text_field'

          div id: 'editor', style: inline(text_align: 'left') do
            rawtext post&.text
          end

          submit_text = post ? 'Update Post' : 'Create Post'
          input type: 'submit', value: submit_text
        end
      end

      def render_js
        script <<~JS
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

      def render_footer
        widget Pager
        super
      end

    end
  end
end
