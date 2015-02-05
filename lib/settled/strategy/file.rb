module Settled
  module Strategy
    module File

      autoload :Json,     'settled/strategy/file/json'
      autoload :Property, 'settled/strategy/file/property'
      autoload :Yaml,     'settled/strategy/file/yaml'

    end
  end
end
