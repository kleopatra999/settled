require 'pathname'
require 'yaml'

module Settled
  module Strategy
    module File
      class Json

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
