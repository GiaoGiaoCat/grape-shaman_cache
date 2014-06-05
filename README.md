# Grape::ShamanCache

## Features

HTTP and server side cache integration for Grape and Jbuilder without Rails application.

If you're not familiar with HTTP caching, ETags and If-Modified-Since, here are some resources.

* [From Zero to API Cache w/ Grape & MongoDB in 10 Minutes](http://www.confreaks.com/videos/986-goruco2012-from-zero-to-api-cache-w-grape-mongodb-in-10-minutes)
* [Doing HTTP Caching Right: Introducing httplib2](http://www.xml.com/lpt/a/1642)
* [Introducing Rack::Cache](http://tomayko.com/writings/rack-cache-announce)


## Installation

Add this line to your application's Gemfile:

    gem 'grape-shaman_cache'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grape-shaman_cache

remember to modify your config.ru file:

```
use Rack::ConditionalGet
use Rack::ETag
```

## Usage

```
class Welcome < Grape::API

  include Grape::ShamanCache

  format :json
  formatter :json, Grape::Formatter::Jbuilder

  get :home, jbuilder: 'welcome/home' do
    @banners = Article.banner.without_gifts
    cache(key: [:v2, :home, @banners.last], expires_in: 2.hours) do
      @banners
    end
  end

end
```

or

```
class Welcome < Grape::API

  include Grape::ShamanCache

  format :json
  formatter :json, Grape::Formatter::Jbuilder

  get :home, jbuilder: 'welcome/home' do
    cache(key: [:v2, :home], expires_in: 2.hours) do
      @banners = Article.banner.without_gifts
    end
  end

end
```

## Configuration

By default `Grape::ShamanCache` will use an instance of `ActiveSupport::Cache::MemoryStore` in a non-Rails application. You can configure it to use any other cache store.

```
Grape::ShamanCache.configure do |config|
  config.cache = ActiveSupport::Cache::FileStore.new("tmp/cache")
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
