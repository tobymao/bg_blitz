class App < Roda
  PRODUCTION = ENV['RACK_ENV'] == 'production'

  plugin :default_headers, {
    'Content-Type' => 'text/html',
    'X-Frame-Options' => 'sameorigin',
    'X-Content-Type-Options' => 'nosniff',
    'X-XSS-Protection' => '1; mode=block',
  }

  use Rack::Session::Cookie, {
    key: '_App_session',
    secret: File.read('.session_secret')
  }

  plugin :csrf

  unless PRODUCTION
    opts[:root] = Dir.pwd
    plugin :static, %w(/html /vendor /images)
  end

  def widget klass, needs = {}
    klass.new(csrf_tag: csrf_tag, **needs).to_html
  end

  def paginated_posts
    page = request['page'] || 1
    Post.order(Sequel.desc(:id)).paginate(page, 10, 0).all
  end

  route do |r|
    r.root do
      widget Views::Home, posts: paginated_posts
    end

    r.on 'admin' do
      r.on 'posts' do
        r.get do
          post = Post[request['id']]
          widget Views::Admin::Posts, post: post, posts: paginated_posts
        end

        r.post do
          Post.create title: request['title'], text: request['text']
          r.redirect '/admin/posts'
        end
      end
    end
  end
end
