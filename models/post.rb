require './models/base'

class Post < Base
  ITEM_REGEX = /{{(.*?)}}/
  dataset_module do
    def published
      where { published_at <= Time.now }
    end
  end

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

  def slug
    title.parameterize
  end

  def path
    "/posts/#{id}/#{slug}"
  end

  def validate
    super
    validates_presence [:title, :text, :description]
  end

  def before_save
    self.tags.map! &:strip
    self.tags.reject! &:empty?
    self.author = nil if self.author.blank?
    self.published_at = nil if self.published_at.blank?

    super
  end

  def pp_published_at
    published_at&.strftime '%B %-d, %Y'
  end
end
