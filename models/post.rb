class Post < Base
  ITEM_REGEX = /{{(.*?)}}/

  def self.post_types
    db_schema[:post_type][:enum_values]
  end

  def item_ids
    item_ids = text.scan(ITEM_REGEX).flatten.uniq
  end

  def map_text
    text.gsub(ITEM_REGEX) { |match| yield match }
  end

  def validate
    super
    validates_presence [:title, :text]
  end
end
