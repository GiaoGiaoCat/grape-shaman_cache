# Rewrite Grape::Formatter::Jbuilder.call defined by 'grape-jbuilder' gem.
module Grape
  module Formatter
    # For maximum performance we are fetching string from redis and return them with no parsing at all
    class Jbuilder
      def self.call(object, env)
        # object is string means that we need to use cache
        return object if object.is_a?(String)
        return new(object.call, env).call if object.is_a?(Proc)
        new(object, env).call
      end
    end
  end
end
