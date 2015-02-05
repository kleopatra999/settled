module Settled
  module Strategy
    module File
      class Yaml

        def initialize( path )
          @path = Pathname.new( path )
        end

        def read
          YAML::load( ::File.read( path.expand_path ))
        end

      protected

        attr_reader :path

      end
    end
  end
end
