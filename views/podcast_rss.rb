require 'rss/2.0'
require 'rss/itunes'

module Views
  module PodcastRSS
    def self.rss posts: posts, items: items
      author = "Board Game Blitz"

      rss = RSS::Rss.new("2.0")
      channel = RSS::Rss::Channel.new

      category = RSS::ITunesChannelModel::ITunesCategory.new 'Other Games'
      channel.itunes_categories << category

      channel.title = 'Board Game Blitz'
      channel.description = 'A podcast about fast games'
      channel.link = "http://www.example.com/"
      channel.language = "en-us"
      channel.copyright = "Copyright #{Date.today.year} Board Game Blitz"
      channel.lastBuildDate = posts.first.updated_at
      # the above uses a method I built on the Audio model that finds
      # the last modified file and makes that the build date for the
      # whole podcast channel

      channel.image = RSS::Rss::Channel::Image.new
      channel.image.url = 'todo'
      channel.image.title = 'Board Game Blitz'
      channel.image.link = 'Should be same as link for whole channel'

      channel.itunes_author = author
      channel.itunes_owner = RSS::ITunesChannelModel::ITunesOwner.new
      channel.itunes_owner.itunes_name=author
      channel.itunes_owner.itunes_email='info@example.com'

      channel.itunes_keywords = %w[boardgames board games gaming cardboard bgg]

      channel.itunes_subtitle = "This appears in the description column of iTunes"
      channel.itunes_summary = "This appears when you click the 'circle I' button in iTunes"

      # below is what iTunes uses for your "album art", different from RSS standard
      channel.itunes_image = RSS::ITunesChannelModel::ITunesImage.new("/path/to/logo.png")
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
        link = "http://boardgameblitz.com/#{item.file_url}"
        channel_item.link = link
        channel_item.itunes_keywords = %w(Keywords For This Particular Audio Clip)
        channel_item.guid = RSS::Rss::Channel::Item::Guid.new
        channel_item.guid.content = link
        channel_item.guid.isPermaLink = true
        channel_item.pubDate = post.updated_at

        description =  post.text.gsub(/(<[^>]*>)|\n|\t/s) {"\n "}
        channel_item.description = description
        channel_item.itunes_summary = description
        channel_item.itunes_subtitle = post.title
        channel_item.itunes_explicit = 'No'
        channel_item.itunes_author = author

        # TODO can add duration once we can compute that somehow

        channel_item.enclosure = RSS::Rss::Channel::Item::Enclosure.new item.file_url, item.file.size, item.file.mime_type
        channel.items << channel_item
      end

      rss.channel = channel
      rss.to_s
    end

  end
end

