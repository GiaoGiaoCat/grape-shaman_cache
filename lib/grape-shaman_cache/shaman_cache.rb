module Grape
  module ShamanCache

      extend ActiveSupport::Concern

      included do
        helpers do

          # Based on actionpack/lib/action_controller/base.rb, line 1216
          def expires_in(seconds, options = {})
            cache_control = []
            cache_control << "max-age=#{seconds}"
            cache_control.delete("no-cache")
            if options[:public]
              cache_control.delete("private")
              cache_control << "public"
            else
              cache_control << "private"
            end

            # This allows for additional headers to be passed through like 'max-stale' => 5.hours
            cache_control += options.symbolize_keys.reject{|k,v| k == :public || k == :private }.map{ |k,v| v == true ? k.to_s : "#{k.to_s}=#{v.to_s}"}

            header "Cache-Control", cache_control.join(', ')
          end

          def default_expire_time
            2.hours
          end

          def cache(opts = {}, &block)
            # HTTP Cache
            cache_key = ActiveSupport::Cache.expand_cache_key(opts[:key])

            # compare_etag(opts[:etag]) # Check if client has fresh version
            # Check if client has fresh version

            # Set Cache-Control
            expire_time = opts[:expires_in] || default_expire_time
            expires_in(expire_time, public: true)

            # Try to fetch from server side cache
            # MemCacheStore's write method supports the :raw option
            # which tells the memcached server to store all values as strings.
            cache = Grape::ShamanCache.config.cache
            cache.fetch(cache_key, raw: true, expires_in: expire_time) do
              Grape::Formatter::Jbuilder.call block, env
            end
          end

        end
      end


  end
end
