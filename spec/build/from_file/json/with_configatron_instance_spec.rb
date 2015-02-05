RSpec.describe do

  before do
    Settled::Settings.build do
      instance :configatron
      file :json, 'spec/fixtures/nested.json'
    end
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
    expect( configatron ).to eql({
      'foo' => 'bar',
      'baz' => {
        'bam' => 'bang',
        'dang' => 1
      }
    })
  end

end
