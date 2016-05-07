require_relative 'base'

module Views
  class Post < Base
    needs :post

    def content
      s = inline(
        'display'    => 'inline-block',
        'text-align' => 'left',
        'max-width'  => '620px',
      )

      div style: s do
        div post.title
        rawtext post.text
        div post.pp_created_at
      end
    end
  end
end
