class Post < Sequel::Model
  def pp_created_at
    created_at.strftime('%B %-d, %Y')
  end
end
