RSpec.describe do

  before do
    Settled::Settings.build do
      file :json, 'spec/fixtures/flat.json'
    end
  end

  it "should have the correct settings" do
    Settled.configuration.should == {
      'foo' => 'bar',
      'baz' => 1
    }
  end

end
