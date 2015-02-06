module Settled
  module Dsl
    class Namespace

      def initialize( &block )
        @files = []

        if block_given?
          block.arity < 1 ?
            instance_eval( &block ) :
            block.call( self )
        end
      end

      def build
        read_files
      end

    protected

      def read_files
        config_hash = {}
        @files.each do |format, paths|
          paths.each do |path|
            config_hash = Dsl::File.new( format, path, config_hash ).build
          end
        end
        config_hash
      end

      def file( format, *paths )
        @files << [format, paths]
      end

      def files( format, *paths )
        file( format, paths )
      end

    end
  end
end
