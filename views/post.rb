require './views/base'

module Views
  class Post < Base
    needs :post
    needs :item_hash

    def content
      s = inline(
        'text-align' => 'left',
        'margin' => '1em 0 1em 0',
        'border-bottom' => '1px solid gray',
        'padding-bottom' => '1.5em',
        'line-height' => '1.3em',
      )

      rendered_text = post.map_text do |id|
        id.gsub!(/[^0-9]/,'')
        render_item item_hash[id.to_i]
      end

      div class: 'post', style: s do
        h1 post.title
        h2 post.pp_created_at
        rawtext rendered_text
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
  end
end
