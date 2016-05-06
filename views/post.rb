module Views
  class Post < Base
    needs :post

    def content
      div post.title
      rawtext post.text
      div post.created_at
    end
  end
end
