RSpec.describe do

  before do
    Settled::Settings.build do
      namespace :some_service do
        file :json, 'spec/fixtures/nested.json'
      end
    end
  end

  it "should have the correct settings" do
    expect( Settled.configuration ).to eql({
      'some_service' => {
        'foo' => 'bar',
        'baz' => {
          'bam' => 'bang',
          'dang' => 1
        }
      }
    })
  end

end
