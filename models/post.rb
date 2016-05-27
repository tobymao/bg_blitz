require './models/base'

class Post < Base
  ITEM_REGEX = /{{(.*?)}}/

  def self.types
    db_schema[:type][:enum_values]
  end

  def item_ids
    text.scan(ITEM_REGEX).flatten.uniq.map(&:to_i)
  end

  def map_text
    text.gsub ITEM_REGEX do |match|
      yield match.gsub(/[^0-9]/,'').to_i
    end
  end

  def summary
    map_text { }
      .gsub(/(<[^>]*>)|\n|\t/, "\n")
      .gsub(/&nbsp/, "\t")
      .strip
  end

  def validate
    super
    validates_presence [:title, :text, :description]
  end

  def before_save
    self.tags.map!(&:strip)
    self.tags.reject!(&:empty?)
    super
  end
end
