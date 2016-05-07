module Views
  module Admin
    class Posts < Admin::Page
      needs :post
      needs :posts

      def render_head
        super
        link rel: 'stylesheet', type: 'text/css', href: '/vendor/quill.snow.css'
        script src: '/vendor/quill.min.js'
      end

      def render_main
        render_new
        render_all
        render_js
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

          es = inline 'text-align' => 'left'

          div id: 'editor', style: es do
            rawtext post&.text
          end

          input type: 'submit'
        end
      end


      def render_all
        ps = inline 'margin' => '0 5px 0 5px'
        fs = inline 'display' => 'inline-block', 'margin-left' => '5px'
        submit_js =  "return confirm('Delete this post?')"

        div 'Previous Posts'

        ul do
          posts.each do |p|
            li do
              span p.id, style: ps
              span p.title, style: ps
              span p.pp_created_at, style: ps

              url = "/admin/posts/#{p.id}"
              a 'edit', href: url, style: ps

              form action: "#{url}/delete", method: 'post', onsubmit: submit_js, style: fs do
                rawtext csrf_tag
                input type: 'submit', value: 'delete'
              end
            end
          end
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
    end
  end
end
