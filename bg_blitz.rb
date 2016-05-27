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
      posts_by type: 'podcast'
    end

    r.is 'videos' do
      posts_by type: 'youtube'
    end

    r.is 'blog' do
      posts_by type: 'blog'
    end

    r.on 'tag/:tag' do |tag|
      posts_by tags: CGI.unescape(tag)
    end

    r.is 'about' do
      widget Views::About
    end

    r.is 'contact' do
      widget Views::Contact
    end

    r.is 'rss.xml' do
      response.headers['content-type'] = 'text/xml'
      data = posts_and_items type: 'podcast'
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

      r.on ['posts/:id', 'posts'] do |id|
        post = Post[id] if id.to_i > 0

        r.get do
          posts = paginate Post
          widget Views::Admin::Posts, post: post, posts: posts
        end

        r.is method: 'post' do
          params = {
            title: r['title'],
            text: r['text'].scrub,
            type: r['type'],
            tags: r['tags'].split(','),
            description: r['description'].scrub,
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

  # instead of counting the database
  # we fetch +1 to see if there's more
  def paginate klass, force = true
    page = request['page'].to_i
    page = 1 if page == 0

    dataset = klass
      .reverse_order(:id)
      .limit(PAGE_LIMIT + 1)
      .offset((page - 1) * PAGE_LIMIT)

    force ? dataset.all : dataset
  end

  def posts_and_items type: nil, tags: nil
    posts = paginate Post, false
    posts = posts.where type: type if type
    posts = posts.where Sequel.pg_array_op(:tags).contains Array(tags) if tags
    posts = posts.all

    item_ids = posts.flat_map &:item_ids
    items = Item.where id: item_ids.uniq
    { posts: posts, items: items.all }
  end

  def posts_by **filter
    data = posts_and_items **filter
    data[:limit] = PAGE_LIMIT
    widget Views::Posts, data
  end
end
