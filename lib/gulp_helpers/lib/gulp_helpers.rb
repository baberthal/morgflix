require 'active_support/all'
require 'action_view/helpers'
require_relative 'gulp_helpers/helpers'
require_relative 'gulp_helpers/config'

module GulpHelpers
  class << self
    @_config = nil

    def config(options = {})
      @_config || @_config = GulpHelpers::Config.new(options)
    end

    def configure
      config.instance_eval do
        yield self
      end
    end

    def method_missing(meth, *args)
      if config.respond_to?(meth)
        config.public_send(meth, *args)
      else
        super
      end
    end

    def respond_to?(meth)
      config.respond_to?(meth) || super
    end
  end
end
