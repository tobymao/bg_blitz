require_relative 'base'

module Views
  class Post < Base
    needs :post
    needs :item_hash

    def content
      s = inline(
        'display'    => 'inline-block',
        'text-align' => 'left',
        'max-width'  => '620px',
      )

      rendered_text = post.map_text do |id|
        id.gsub!(/[^0-9]/,'')
        render_item item_hash[id.to_i]
      end

      div style: s do
        div post.title
        div post.pp_created_at
        rawtext rendered_text
      end
    end

    def render_item item
      case item.item_type
      when 'audio'
        Audio.new(file: item.file).to_html
      when 'image'
        Base.inline_html { img src: item.file_url }
      when 'youtube'
        Base.inline_html { text item.file_url }
      end
    end
  end
end
