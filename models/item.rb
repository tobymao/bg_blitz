require_relative '../uploaders/item_uploader.rb'

class Item < Base
  include ItemUpdloader[:file]

  def self.item_types
    db_schema[:item_type][:enum_values]
  end

  def before_validation
    super

    case file&.mime_type&.split('/')&.first
    when 'image'
      self.item_type = 'image'
    when 'audio'
      self.item_type = 'audio'
    else
      self.item_type = 'youtube' if external_url&.include? 'youtube'
    end
  end

  def before_create
    super
    self.external_url = nil if file
  end
end
