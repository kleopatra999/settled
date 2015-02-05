module Settled
  class Settings

    attr_reader :configuration

    def self.build( &block )
      Settled::Settings.new( &block )
    end

    def initialize( &block )
      @configuration = {}
      @instance_strategies = []

      if block_given?
        block.arity < 1 ?
          instance_eval( &block ) :
          block.call( self )
      end

      finish_setup
    end

  protected

    def container( klass )
      @container = Dsl::Container.new( klass )
    end

    def file( format, path )
      @configuration = _container.instance( Dsl::File.new( format, path, configuration ).build )
    end

    def instance( *args )
      @instance_strategies << args
    end

  private

    def finish_setup
      Settled.configuration = configuration

      instance_strategies.each do |strategy|
        apply_instance_strategy( strategy )
      end
    end

    def apply_instance_strategy( strategy )
      case strategy.first
        when :none
          # do nothing
        when :configatron
          Strategy::Instance::Configatron.new.define
        when :constant
          Strategy::Instance::Constant.new( strategy.last, @configuration ).define
        else
          raise NotImplementedError, "Instance strategy not defined: #{strategy.first}"
      end
    end

    def instance_strategies
      @instance_strategies || [%i(none)]
    end

    def _container
      @container || Dsl::Container.new( Hash )
    end

  end
end
