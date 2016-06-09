require './views/base'

module Views
  class Post < Base
    needs :post
    needs :item_hash
    needs solo: false

    def content
      style_hash = {
        text_align: 'left',
        margin: '1em 0 1em 0',
        padding_bottom: '1.5em',
        line_height: '1.3em',
      }

      style_hash[:border_bottom] = '1px solid gray' unless solo

      post_style = inline style_hash

      rendered_text = post.map_text do |id|
        render_item item_hash[id]
      end

      div style: post_style do
        post_path = "/posts/#{post.id}/#{post.title}"
        link_style = inline color: 'black', font_weight: 'normal'

        a href: post_path, style: link_style do
          h1 post.title
        end

        h2 post.pp_created_at

        rawtext rendered_text

        more_style = inline(
          border_top: '1px solid gray',
          margin_top: '1em',
          width: '6em',
        )

        div style: more_style  do
          a 'Read More', href: post_path
        end unless solo

        render_tags
      end
    end

    def render_item item
      case item&.type
      when 'audio'
        Audio.new(file: item.file).to_html
      when 'image'
        Base.inline_html { img src: item.file_url }
      when 'youtube'
        Youtube.new(url: item.external_url).to_html
      else
        ''
      end
    end

    def render_tags
      tag_style = inline(
        border_radius: '0.5em',
        padding: '0.2em 0.5em',
        background: 'gray',
        margin_right: '1em',
        text_decoration: 'none',
        font_size: '0.8em',
        font_weight: 'normal',
        margin_top: '1em',
        color: 'white',
      )

      div style: inline(margin_top: '1em', line_height: '2em') do
        post.tags.each do |tag|
          div style: inline(display: 'inline-block') do
            a tag, href: "/tag/#{tag}", style: tag_style
          end
        end
      end
    end
  end

end
