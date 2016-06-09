require './views/page'

module Views
  class About < Page
    def render_main
      ambie_icons = [
        Icons::Icon.new('bgg', 'https://boardgamegeek.com/user/ambierona', 'BGG'),
        Icons::Icon.new('youtube', 'https://www.youtube.com/ambierona', 'Youtube'),
      ]

      text_style = inline line_height: '1.3em'

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
        Icons::Icon.new('bgg', 'https://boardgamegeek.com/user/noajayne', 'BGG'),
        Icons::Icon.new('twitter', 'https://twitter.com/noajayne', 'Twitter'),
      ]

      render_box 'Cassadi', BGB_PINK, cassadi_icons, 205, 171

      div style: text_style do
        text "Cassadi has been board gaming for roughly 10 years. Though, the acquisition disorder didn't set in until 2 years ago. "\
          "Since then she has played hundreds of different games, and found she enjoys teaching new players almost as much as she "\
          "enjoys playing her favorites. Some at the top of the list are Carcassonne, Five Tribes, Tokaido, and Puerto Rico. She will "\
          "try most any game once! Other than board gaming Cassadi enjoys being a local craft beer snob and spending time with her family."
      end

      crystal_icons = [
        Icons::Icon.new('bgg', 'https://boardgamegeek.com/user/CrysP', 'BGG'),
        Icons::Icon.new('twitter', 'https://twitter.com/CrystalPisano', 'Twitter'),
      ]

      render_box 'Crystal', BGB_PURPLE, crystal_icons, 69, 35

      div style: text_style do
        text "From humble beginnings of Battleship, Kerplunk, Dream Phone, Arch Rival, and Mall Madness... the obsession started early. "\
          "Crystal has been gaming her whole life, but it wasn't until she was invited to game night at a friend's house in 2007 that "\
          "she was introduced to modern board games. Early favorites included Betrayal at House on the Hill, Saint Petersburg, and Runebound. "\
          "Crystal's personal game collection has grown in the years since and she enjoys a wide range of games, particularly those where the "\
          "theme is well implemented. Battlestar Galactica is her favorite, but her more recent loves include Pandemic Legacy and T.I.M.E. "\
          "Stories. She'll tell you she hates euro games, but she's willing to give any game a shot if it's with the right group."
      end
    end
    static :render_main

    def page_title
      'About'
    end

    def render_box name, color, icons, x, y
      box_style = inline(
        display: 'inline-block',
        color: 'white',
        width: '7em',
        font_size: '150%',
        margin: '.5em 0 .5em 0',
        text_transform: 'uppercase',
        text_align: 'center',
        vertical_align: 'top',
        background_color: color,
        padding: '.2em 0 .2em 0',
      )

      style Icons.icons_css(name, Icons::ICONS, x, y, 30)

      div style: box_style do
        text name
      end

      ul style: inline(display: 'inline-block', margin_top: '4px') do
        icons.each do |data|
          li class: "icon #{data.klass} #{name}" do
            a href: data.url, tooltip: data.name
          end
        end
      end
    end

  end
end
