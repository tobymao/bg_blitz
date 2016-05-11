PRODUCTION = ENV['RACK_ENV'] == 'production'

require 'roda'
require 'fortitude'
require 'shrine'
require './models.rb'

Shrine.plugin :sequel
Shrine.plugin :rack_file
Shrine.plugin :validation_helpers

unless PRODUCTION
  require 'better_errors'
  require "shrine/storage/file_system"

  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'),
    store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/store'),
  }
end

FOLDERS = %w[views models uploaders]

FOLDERS.each do |folder|
  Dir["./#{folder}/**/*.rb" ].each { |file| require file }
end

class BGBlitz < Roda
  unless PRODUCTION
    opts[:root] = Dir.pwd
    plugin :static, %w[/html /vendor /images /uploads]
    use BetterErrors::Middleware
    BetterErrors.application_root = __dir__
  end

  use Rack::Session::Cookie, key: '_App_session', secret: File.read('.session_secret')

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
    "You are forbidden from seeing that!"
  end

  status_handler 404 do
    "Where did it go?"
  end

  route do |r|
    Views::Base.csrf_tag = csrf_tag
    Views::Base.current_path = r.path
    Views::Base.params = r.params

    r.root do
      posts_by_type
    end

    r.is 'podcasts' do
      posts_by_type 'podcast'
    end

    r.is 'videos' do
      posts_by_type 'youtube'
    end

    r.is 'blog' do
      posts_by_type 'blog'
    end

    r.is 'about' do
      widget Views::About
    end

    r.is 'contact' do
      widget Views::Contact
    end

    r.is 'rss.xml' do
      response.headers['content-type'] = 'xml'
      data = posts_and_items 'podcast'
      Views::PodcastRSS.rss data
    end

    r.on 'admin' do
      r.basic_auth do |user, pass|
        [user, pass] == [ENV['AUTH_USER'], ENV['AUTH_PASS']]
      end

      r.on ['items/:id', 'items'] do |id|
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

          item =
            if item
              item.update params
            else
              Item.create params
            end

          r.redirect "/admin/items/#{id}"
        end

        r.is 'delete', method: 'post' do
          item.destroy
          r.redirect '/admin/items'
        end
      end

      r.on ['posts/:id', 'posts'] do |id|
        post = Post[id] if id.to_i > 0

        r.get do
          posts = paginate Post
          widget Views::Admin::Posts, post: post, posts: posts
        end

        r.is method: 'post' do
          params = { title: r['title'], text: r['text'], type: r['type'] }

          post =
            if post
              post.update params
            else
              Post.create params
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
    klass.new(**needs).to_html
  end

  def paginate klass, force = true
    page = (request['page'] || 1).to_i
    dataset = klass.reverse_order(:id).paginate(page, 10, 0)
    force ? dataset.all : dataset
  end

  def posts_and_items type = nil
    posts = paginate Post, false
    posts = posts.where type: type if type
    posts = posts.all

    item_ids = posts.flat_map &:item_ids
    items = Item.where id: item_ids.uniq
    { posts: posts, items: items }
  end

  def posts_by_type type = nil
    data = posts_and_items type
    widget Views::Posts, data
  end
end
