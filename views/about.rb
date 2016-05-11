require './views/page'

module Views
  class About < Page
    def render_main
      ambie_icons = [
        Icons::Icon.new('facebook', 'https://www.facebook.com/ambie.valdes', 'Facebook'),
        Icons::Icon.new('bgg', 'https://boardgamegeek.com/user/ambierona', 'BGG'),
        Icons::Icon.new('youtube', 'https://www.youtube.com/channel/UCvt8rhQ0E0MThxaFLCbGoWw', 'Youtube'),
      ]

      text_style = inline 'line-height' => '1.3em'

      render_box 'Ambie', BGB_BLUE, ambie_icons, 137, 103

      div style: text_style do
        text "Ambie has been playing games for as long as she can remember. When she was a kid, she played board, card, and video games "\
          "with her family (classics like Monopoly, Risk, Clue, Stratego, Rummikub, Gin, Euchre...). She also used to play D&D "\
          "with her family on camping trips. In college, she started playing 'modern' board games with friends, starting with Dominion "\
          "and Tichu. After graduating college, she and her boyfriend (now husband) started building up a collection and getting more "\
          "into the hobby together. Now, Ambie plays a lot of 2-player games with her husband. They enjoy thematic Euros - games that "\
          "integrate the mechanics with the theme. Some of Ambie's favorite games are The Resistance: Avalon, Codenames, Arkwright, Space "\
          "Alert, and Tragedy Looper. Outside of board games, she enjoys singing, knitting, crocheting, and Brazilian Jiu Jitsu."
      end

      cassadi_icons = [
        Icons::Icon.new('facebook', 'https://www.facebook.com/ambie', 'Facebook'),
        Icons::Icon.new('bgg', 'https://www.facebook.com/ambie', 'BGG'),
        Icons::Icon.new('youtube', 'https://www.facebook.com/ambie', 'Youtube'),
      ]

      render_box 'Cassadi', BGB_PINK, cassadi_icons, 205, 171

      div style: text_style do
        text "Cassadi has been playing games for as long as she can remember. When she was a kid, she played board, card, and video games "\
          "with her family (classics like Monopoly, Risk, Clue, Stratego, Rummikub, Gin, Euchre...). She also used to play D&D "\
          "with her family on camping trips. In college, she started playing 'modern' board games with friends, starting with Dominion "\
          "and Tichu. After graduating college, she and her boyfriend (now husband) started building up a collection and getting more "\
          "into the hobby together. Now, Ambie plays a lot of 2-player games with her husband. They enjoy thematic Euros - games that "\
          "integrate the mechanics with the theme. Some of Ambie's favorite games are The Resistance: Avalon, Codenames, Arkwright, Space "\
          "Alert, and Tragedy Looper. Outside of board games, she enjoys singing, knitting, crocheting, and Brazilian Jiu Jitsu."
      end

      crystal_icons = [
        Icons::Icon.new('facebook', 'https://www.facebook.com/ambie', 'Facebook'),
        Icons::Icon.new('bgg', 'https://www.facebook.com/ambie', 'BGG'),
        Icons::Icon.new('youtube', 'https://www.facebook.com/ambie', 'Youtube'),
      ]

      render_box 'Crystal', BGB_PURPLE, crystal_icons, 69, 35

      div style: text_style do
        text "Crystal has been playing games for as long as she can remember. When she was a kid, she played board, card, and video games "\
          "with her family (classics like Monopoly, Risk, Clue, Stratego, Rummikub, Gin, Euchre...). She also used to play D&D "\
          "with her family on camping trips. In college, she started playing 'modern' board games with friends, starting with Dominion "\
          "and Tichu. After graduating college, she and her boyfriend (now husband) started building up a collection and getting more "\
          "into the hobby together. Now, Ambie plays a lot of 2-player games with her husband. They enjoy thematic Euros - games that "\
          "integrate the mechanics with the theme. Some of Ambie's favorite games are The Resistance: Avalon, Codenames, Arkwright, Space "\
          "Alert, and Tragedy Looper. Outside of board games, she enjoys singing, knitting, crocheting, and Brazilian Jiu Jitsu."
      end
    end
    static :render_main

    def render_box name, color, icons, x, y
      box_style = inline(
        'display' => 'inline-block',
        'color' => 'white',
        'width' => '7em',
        'font-size' => '150%',
        'margin' => '.5em 0 .5em 0',
        'text-transform' => 'uppercase',
        'text-align' => 'center',
        'vertical-align' => 'top',
        'background-color' => color,
        'padding' => '.2em 0 .2em 0',
      )

      style Icons.icons_css(name, Icons::ICONS, x, y, 30)

      div style: box_style do
        text name
      end

      ul style: inline(display: 'inline-block', 'margin-top': '4px') do
        icons.each do |data|
          li class: "icon #{data.klass} #{name}" do
            a href: data.url, tooltip: data.name
          end
        end
      end
    end

  end
end
