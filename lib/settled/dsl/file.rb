module Settled
  module Dsl
    class File

      def initialize( format, path, settings )
        @format   = format
        @path     = path
        @settings = settings
      end

      def build
        settings.merge( settings_from_file )
      end

    protected

      attr_reader :format,
                  :path,
                  :settings

      def settings_from_file
        strategy_klass.new( path ).read
      end

      def strategy_klass
        if Settled::Strategy::File::const_defined?( strategy_klass_name )
          return Settled::Strategy::File::const_get( strategy_klass_name )
        end

        raise_unknown_format
      end

      def strategy_klass_name
        return :Json if format == :json
        return :Yaml if format == :yaml

        raise_unknown_format
      end

      def raise_unknown_format
        raise NotImplementedError, "File read strategy is not implemented for format: #{format}"
      end

    end
  end
end
