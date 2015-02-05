require "settled/version"

module Settled

  autoload :Dsl,      'settled/dsl'
  autoload :Settings, 'settled/settings'
  autoload :Strategy, 'settled/strategy'

  class << self

    attr_accessor :configuration

  end

end
