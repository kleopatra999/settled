require 'hashie'

RSpec.describe do

  before do
    Settled::Settings.build do
      container Hashie::Mash
      file :json, 'spec/fixtures/nested.json'
    end
  end

  it "should have the correct container type" do
    expect( Settled.configuration.class ).to eql( Hashie::Mash )
  end

  it "should have the correct setting for foo" do
    expect( Settled.configuration.foo ).to eql( 'bar' )
  end

end
