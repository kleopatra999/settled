RSpec.describe do

  before do
    Settled::Settings.build do
      file :yaml, 'spec/fixtures/config.yml'
    end
  end

  it "should have the correct settings" do
    expect( Settled.configuration ).to eql({
      'foo' => 'bar',
      'baz' => 1
    })
  end

end
