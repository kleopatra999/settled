module Settled
  class Settings

    attr_reader :configuration

    def self.build( &block )
      Settled.configuration = Settled::Settings.new( &block ).configuration
    end

    def initialize( &block )
      @configuration = {}

      if block_given?
        block.arity < 1 ?
          instance_eval( &block ) :
          block.call( self )
      end
    end

    def file( format, path )
      @configuration = Dsl::File.new( format, path, configuration ).build
    end

  end
end
