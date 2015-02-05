RSpec.describe do

  before do
    Settled::Settings.build do
      instance :constant, :CONFIG
      file :json, 'spec/fixtures/nested.json'
    end
  end

  after do
    Kernel.send :remove_const, :CONFIG
  end

  it "should have the correct settings" do
    expect( Settled.configuration ).to eql({
      'foo' => 'bar',
      'baz' => {
        'bam' => 'bang',
        'dang' => 1
      }
    })
  end

  it "should have the correct settings with the specified instance strategy" do
    expect( CONFIG ).to eql({
      'foo' => 'bar',
      'baz' => {
        'bam' => 'bang',
        'dang' => 1
      }
    })
  end

end
