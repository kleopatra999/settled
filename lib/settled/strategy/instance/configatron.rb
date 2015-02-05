module Settled
  module Strategy
    module Instance
      class Configatron

        def initialize
          @name = 'configatron'
        end

        def define
          Kernel.send( :define_method, name ) do
            Settled.configuration
          end
        end

      protected

        attr_reader :name

      end
    end
  end
end
