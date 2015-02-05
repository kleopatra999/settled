module Settled
  module Dsl
    class Container

      def initialize( klass )
        @klass = klass
      end

      def instance( settings_hash )
        return settings_hash if klass.nil? || klass == Hash

        klass.new( settings_hash )
      end

    protected

      attr_reader :klass

    end
  end
end
