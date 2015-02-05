module Settled
  module Strategy
    module Instance
      class Constant

        def initialize( name, container )
          @container = container
          @name      = name
        end

        def define
          Kernel::const_set( name, container )
        end

      protected

        attr_reader :container,
                    :name

      end
    end
  end
end
