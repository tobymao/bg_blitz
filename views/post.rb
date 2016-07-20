require './views/base'

module Views
  class Post < Base
    needs :post
    needs :item_hash
    needs solo: false

    LIMIT = 5
    DIV   = '</div>'

    def content
      style_hash = {
        text_align: 'left',
        margin: '1em 0 1em 0',
        padding_bottom: '1.5em',
        line_height: '1.3em',
      }

      style_hash[:border_bottom] = '1px solid gray' unless solo

      post_style = inline style_hash

      rendered_text = post.map_text do |id|
        render_item item_hash[id]
      end

      truncated =
        unless solo
          parts = rendered_text.split DIV
          rendered_text = parts.take(LIMIT).map { |l| l << DIV }.join if parts.size > LIMIT
        end

      div style: post_style do
        link_style = inline color: 'black', font_weight: 'normal'

        a href: post.path, style: link_style do
          h1 post.title
        end

        h2 post.pp_published_at

        div style: inline(font_style: 'italic', font_size: '0.8em', margin_bottom: '0.7em') do
          text "by #{post.author}" if post.author
        end

        rawtext rendered_text

        div style: inline(position: 'relative') do
          more_style = inline(
            border_top: '1px solid gray',
            margin_top: '1em',
            width: '6em',
            display: 'inline-block',
          )

          div style: more_style  do
            a 'Read More', href: post.path
          end if truncated

          comments_style = inline(
            right: 0,
            top: '1em',
            position: 'absolute',
          )

          a href: "#{page_url}#disqus_thread", style: comments_style unless solo
        end

        render_tags
        if solo
          render_social
          render_disqus
        end
      end
    end

    def render_item item
      case item&.type
      when 'audio'
        Audio.new(file: item.file).to_html
      when 'image'
        Base.inline_html { img src: item.file_url }
      when 'youtube'
        Youtube.new(url: item.external_url).to_html
      else
        ''
      end
    end

    def render_tags
      tag_style = inline(
        border_radius: '0.5em',
        padding: '0.2em 0.5em',
        background: 'gray',
        margin_right: '1em',
        text_decoration: 'none',
        font_size: '0.8em',
        font_weight: 'normal',
        margin_top: '1em',
        color: 'white',
      )

      div style: inline(margin_top: '1em', line_height: '2em') do
        post.tags.each do |tag|
          div style: inline(display: 'inline-block') do
            a tag, href: "/tag/#{CGI.escape tag}", style: tag_style
          end
        end
      end
    end

    def render_social
      share_style = inline(
        border_bottom: '1px solid gray',
        margin_top: '1.5em',
        display: 'inline-block',
        vertical_align: 'bottom',
        width: '3em',
      )

      div style: share_style do
        text 'Share:'
      end

      facebook_url = URI.encode "https://www.facebook.com/sharer.php?u=#{page_url}"
      social_button facebook_url, 'Share on Facebook', '/images/facebook.png'

      reddit_url = URI.encode "https://reddit.com/submit?url=#{page_url}&title=#{post.title}"
      social_button reddit_url, 'Share on Facebook', '/images/reddit.png'

      twitter_url = URI.encode "https://twitter.com/intent/tweet?source=#{page_url}&text=#{post.title}: #{page_url}"
      social_button twitter_url, 'Tweet', '/images/twitter.png'
    end

    def social_button url, title, image_url
      button_style = inline(
        margin_left: '0.3em',
      )
      a href: url, target: '_blank', title: title, style: button_style do
        img src: image_url, style: inline(height: '1.5em')
      end
    end

    def render_disqus
      div id: 'disqus_thread', style: inline(margin_top: '1em')

      script <<~JS
        var disqus_config = function () {
          this.page.url = '#{page_url}';
          this.page.identifier = '#{identifier}';
        };
        (function() {
          var d = document, s = d.createElement('script');
          s.src = '//boardgameblitz.disqus.com/embed.js';
          s.setAttribute('data-timestamp', +new Date());
          (d.head || d.body).appendChild(s);
        })();
      JS

      noscript do
        span 'Please enable JavaScript to view the '
        a href: 'https://disqus.com/?ref_noscript', rel: 'nofollow' do
          text 'comments powered by Disqus.'
        end
      end
    end

    # TODO don't hardcode this url
    def page_url
      "http://boardgameblitz.com#{identifier}"
    end

    def identifier
      post.path
    end
  end
end
