require 'hashie'

RSpec.describe do

  class DotNotationContainer

    def initialize( settings_hash )
      @settings = settings_hash
    end

    def []( dot_path )
      val = settings

      dot_path.split( '.' ).each do |part|
        val = val[part]
      end

      val
    end

  protected

    attr_reader :settings

  end

  before do
    Settled::Settings.build do
      container DotNotationContainer
      file :json, 'spec/fixtures/nested.json'
    end
  end

  it "should have the correct container type" do
    expect( Settled.configuration.class ).to eql( DotNotationContainer )
  end

  it "should have the correct setting for foo" do
    expect( Settled.configuration['foo'] ).to eql( 'bar' )
  end

  it "should have the correct setting for baz.dang" do
    expect( Settled.configuration['baz.dang'] ).to eql( 1 )
  end

end
