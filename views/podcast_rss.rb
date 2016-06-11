require 'rss/2.0'
require 'rss/itunes'

module Views
  module PodcastRSS
    NAME      = 'Board Game Blitz'.freeze
    SITE_URL  = 'http://www.boardgameblitz.com'.freeze
    IMAGE_URL = SITE_URL + '/images/logo_itunes.jpg'.freeze

    def self.rss posts:, items:
      rss = RSS::Rss.new '2.0'
      channel = RSS::Rss::Channel.new

      parent_category = RSS::ITunesChannelModel::ITunesCategory.new 'Games & Hobbies'
      child_category = RSS::ITunesChannelModel::ITunesCategory.new 'Other Games'
      parent_category.itunes_categories << child_category
      channel.itunes_categories << parent_category

      channel.title = NAME
      channel.description = 'A shorter (30 minute) podcast covering a wide variety of games.'
      channel.link = SITE_URL
      channel.language = 'en-us'
      channel.copyright = "Copyright #{Date.today.year} Board Game Blitz"
      channel.lastBuildDate = posts.first&.updated_at

      channel.image = RSS::Rss::Channel::Image.new
      channel.image.url = IMAGE_URL
      channel.image.title = NAME
      channel.image.link = SITE_URL

      channel.itunes_author = NAME
      channel.itunes_owner = RSS::ITunesChannelModel::ITunesOwner.new
      channel.itunes_owner.itunes_name= NAME
      channel.itunes_owner.itunes_email= 'boardgameblitz@gmail.com'

      channel.itunes_keywords = %w[boardgame board game games gaming cardboard bgg blitz tabletop]
      channel.itunes_subtitle = 'Podcasts on the go!'
      channel.itunes_summary = 'Ambie, Cassadi, and Crystal discussing various topics about board games'

      # below is what iTunes uses for your "album art", different from RSS standard
      channel.itunes_image = RSS::ITunesChannelModel::ITunesImage.new IMAGE_URL
      # above could also be "Yes" or "Clean"
      channel.itunes_explicit = 'No'

      item_hash = items.each_with_object({}) do |item, hash|
        hash[item.id] = item
      end

      posts.each do |post|
        items = post.item_ids.map { |id| item_hash[id] }
        item = items.find { |item| item.type == 'audio' }

        channel_item = RSS::Rss::Channel::Item.new
        channel_item.title = post.title
        channel_item.pubDate = post.published_at
        channel_item.description = post.description

        file_url = SITE_URL + item.file_url
        channel_item.guid = RSS::Rss::Channel::Item::Guid.new
        channel_item.guid.content = file_url
        channel_item.enclosure = RSS::Rss::Channel::Item::Enclosure.new(
          file_url,
          item.file.size,
          item.file.mime_type,
        )

        channel_item.itunes_summary = post.description
        channel_item.itunes_subtitle = post.title
        channel_item.itunes_explicit = 'No'
        channel_item.itunes_author = NAME
        channel_item.itunes_keywords = post.tags
        channel_item.itunes_duration = RSS::ITunesItemModel::ITunesDuration.new
        channel_item.itunes_duration.content = item.itunes_duration

        channel.items << channel_item
      end

      rss.channel = channel
      rss.to_s
    end

  end
end
