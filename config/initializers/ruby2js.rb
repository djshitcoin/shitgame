require 'ruby2js/filter/return'
require 'ruby2js/filter/functions'

module Ruby2JS
  module Rails
    class SprocketProcessor
      def initialize( file)
        @file = file
      end
      def render(context , _)
        context = context.instance_eval { binding } unless context.is_a? Binding
        Ruby2JS.convert(File.read(@file), binding: context).to_s
      end
    end

    class Engine < ::Rails::Engine
      engine_name "ruby2js"

      config.assets.configure do |env|
        env.register_engine '.rb', SprocketProcessor, silence_deprecation: true
      end

    end

  end

end