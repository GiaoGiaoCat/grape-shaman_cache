# Rewrite Grape::Formatter::Jbuilder.call defined by 'grape-jbuilder' gem.
module Grape
  module Formatter
    # For maximum performance we are fetching string from redis and return them with no parsing at all
    module Jbuilder
      def self.call(object, env)
        @env      = env
        @endpoint = env['api.endpoint']
        # object is string means that we need to use cache
        return object if object.is_a?(String)

        if jbuilderable?
          jbuilder do |template|
            engine = ::Tilt.new(view_path(template), nil, view_path: env['api.tilt.root'])
            engine.render(endpoint, {})
          end
        else
          Grape::Formatter::Json.call object, env
        end
      end
    end
  end
end
