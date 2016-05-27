module Views
  module Icons
    Icon = Struct.new :klass, :url, :name, :hidden

    SPRITE_URL = '/images/icon_sprites.png'

    ICONS = [
      Icon.new('rss', '/rss.xml', 'RSS'),
      Icon.new('facebook', 'https://www.facebook.com/BGBlitz', 'Facebook'),
      Icon.new('twitter', 'https://twitter.com/bgameblitz', 'Twitter'),
      Icon.new('google', 'https://google.com', 'Google', true),
      Icon.new('youtube', 'https://www.youtube.com/channel/UC-zQPrSCinOtta_INepZo_A', 'YouTube'),
      Icon.new('itunes', 'https://itunes.apple.com/us/podcast/board-game-blitz/id1117729882?mt=2', 'iTunes'),
      Icon.new('bgg', 'https://boardgamegeek.com/guild/2581', 'BGG Guild'),
    ]

    def self.icons_css id, icons, x, y, step
      value = 0

      icons.each_with_object(String.new) do |icon, css|
        css << <<~CSS
          .icon.#{icon.klass}.#{id} { background: url(#{SPRITE_URL}) #{value}px #{x}px; }
          .icon.#{icon.klass}.#{id} a:hover { background: url(#{SPRITE_URL}) #{value}px #{y}px; }
        CSS

        value -= step
      end
    end

  end
end
