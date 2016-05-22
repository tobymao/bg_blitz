require './uploaders/item_uploader'
require './models/base'

class Item < Base
  include ItemUpdloader[:file]

  def self.types
    db_schema[:type][:enum_values]
  end

  def before_validation
    super

    case file&.mime_type&.split('/')&.first
    when 'image'
      self.type = 'image'
    when 'audio'
      self.type = 'audio'
    else
      self.type = 'youtube' if external_url&.include? 'youtube'
    end
  end

  def before_create
    super
    self.external_url = nil if file
  end
end
