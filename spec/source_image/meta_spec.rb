describe "Meta" do
  before :each do
    @parser = SourceImage::Parser.new
  end

  it "Flickr should return meta data" do
    @parser.parse('http://www.flickr.com/photos/49354690@N04/8498281772/')[:meta]["title"].should be_a String
  end
end
