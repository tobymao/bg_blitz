PRODUCTION = ENV['RACK_ENV'] == 'production'

require 'roda'
require 'fortitude'
require 'shrine'
require "shrine/storage/file_system"
require './models.rb'

Shrine.plugin :sequel
Shrine.plugin :rack_file
Shrine.plugin :validation_helpers

SHRINE_PATH = PRODUCTION ? '/home/deploy/public/bg_blitz' : 'public'

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new('/tmp/bg_blitz'),
  store: Shrine::Storage::FileSystem.new(SHRINE_PATH, prefix: 'uploads/store'),
}

FOLDERS = %w[views models uploaders]

FOLDERS.each do |folder|
  Dir["./#{folder}/**/*.rb" ].each { |file| require file }
end

unless PRODUCTION
  require 'better_errors'
end

class BGBlitz < Roda
  PAGE_LIMIT = 10.freeze

  unless PRODUCTION
    opts[:root] = Dir.pwd
    plugin :static, %w[/html /vendor /images /uploads]
    use BetterErrors::Middleware
    BetterErrors.application_root = __dir__
  end

  use Rack::Session::Cookie, key: '_App_session', secret: ENV['SECRET']

  plugin :default_headers, {
    'Content-Type' => 'text/html',
    'X-Frame-Options' => 'sameorigin',
    'X-Content-Type-Options' => 'nosniff',
    'X-XSS-Protection' => '1; mode=block',
  }

  plugin :csrf
  plugin :basic_auth
  plugin :status_handler

  status_handler 403 do
    'You are forbidden from seeing that!'
  end

  status_handler 404 do
    "Uh oh, there doesn't seem to be anything here."
  end

  route do |r|
    r.root do
      posts_by
    end

    r.is 'podcasts' do
      posts_by 'Podcasts', type: 'podcast'
    end

    r.is 'videos' do
      posts_by 'Videos', type: 'youtube'
    end

    r.is 'blog' do
      posts_by 'Blog', type: 'blog'
    end

    r.on 'posts', Integer do |id|
      post = Post[id]

      r.is do
        r.redirect post.path
      end

      r.on String do |name|
        r.redirect post.path unless name == post.slug

        items = Item.where id: post.item_ids.uniq
        data = { posts: [post], items: items.all, page_title: post.title, solo: true }
        widget Views::Posts, data
      end
    end

    r.on 'tag', String do |tag|
      clean_tag = CGI.unescape(tag)
      posts_by clean_tag, tags: clean_tag
    end

    r.is 'about' do
      widget Views::About
    end

    r.is 'support' do
      widget Views::Support
    end

    r.is 'con' do
      widget Views::Con
    end

    r.is 'archives' do
      posts = ordered(Post).published.all
      widget Views::Archives, posts: posts
    end

    r.is 'rss.xml' do
      response.headers['content-type'] = 'text/xml'
      data = posts_and_items type: 'podcast', paged: false
      Views::PodcastRSS.rss data
    end

    r.on 'admin' do
      r.basic_auth do |user, pass|
        [user, pass] == [ENV['AUTH_USER'], ENV['AUTH_PASS']]
      end

      r.on 'items', [Integer, true] do |id|
        item = Item[id] if id.to_i > 0

        r.get do
          items = paginate Item
          widget Views::Admin::Items, item: item, items: items
        end

        r.is method: 'post' do
          params = {
            title: r['title'],
            file: r['file'],
            external_url: r['external_url'],
          }

          if item
            item.update params
          else
            item = Item.create params
          end

          r.redirect "/admin/items/#{id}"
        end

        r.is 'delete', method: 'post' do
          item.destroy
          r.redirect '/admin/items'
        end
      end

      r.on 'posts', [Integer, true] do |id|
        post = Post[id] if id.to_i > 0

        r.get do
          tags = Post.distinct.select_order_map(Sequel.pg_array_op(:tags).unnest)
          posts = paginate Post
          widget Views::Admin::Posts, post: post, posts: posts, tags: tags
        end

        r.is method: 'post' do
          params = {
            title: r['title'],
            author: r['author'],
            text: r['text'],
            type: r['type'],
            tags: r['tags'].split(','),
            description: r['description'],
            published_at: r['published_at'],
          }

          if post
            post.update params
          else
            post = Post.create params
          end

          r.redirect "/admin/posts/#{post.id}"
        end

        r.is 'delete', method: 'post' do
          post.destroy
          r.redirect '/admin/posts'
        end
      end
    end
  end

  def widget klass, needs = {}
    needs[:csrf_tag] ||= csrf_tag
    needs[:request] ||= request
    klass.new(**needs).to_html
  end

  def ordered klass
    order_by = klass.columns.include?(:published_at) ? :published_at : :id
    klass.reverse_order(order_by)
  end

  # instead of counting the database
  # we fetch +1 to see if there's more
  def paginate klass, force = true
    dataset = ordered(klass).limit(PAGE_LIMIT + 1).offset((page - 1) * PAGE_LIMIT)
    force ? dataset.all : dataset
  end

  def posts_and_items type: nil, tags: nil, paged: true
    posts = paged ? paginate(Post, false) : ordered(Post)
    posts = posts.where type: type if type
    posts = posts.where Sequel.pg_array_op(:tags).contains Array(tags) if tags
    posts = posts.published.all

    item_ids = posts.flat_map &:item_ids
    items = Item.where id: item_ids.uniq
    { posts: posts, items: items.all }
  end

  def posts_by title = nil, **filter
    title = [title, "Page #{page}"].compact.join ' | ' if page > 1

    data = posts_and_items **filter
    data[:limit] = PAGE_LIMIT
    data[:page_title] = title
    widget Views::Posts, data
  end

  def page
    p = request['page'].to_i
    p <= 0 ? 1 : p
  end
end
