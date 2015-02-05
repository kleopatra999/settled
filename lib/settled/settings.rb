module Settled
  class Settings

    attr_reader :configuration

    def self.build( &block )
      Settled::Settings.new( &block )
    end

    def initialize( &block )
      @configuration = {}
      @files = []
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

    def file( format, paths )
      @files << [format, Array(paths)]
    end

    def files( format, paths )
      file( format, paths )
    end

    def instance( *args )
      @instance_strategies << args
    end

  private

    def finish_setup
      config_hash = read_files

      Settled.configuration = @configuration = _container.instance( config_hash )

      instance_strategies.each do |strategy|
        apply_instance_strategy( strategy )
      end
    end

    def read_files
      config_hash = {}
      @files.each do |format, paths|
        paths.each do |path|
          config_hash = Dsl::File.new( format, path, config_hash ).build
        end
      end
      config_hash
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
