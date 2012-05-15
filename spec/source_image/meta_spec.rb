describe "Meta" do
  before :each do
    @parser = SourceImage::Parser.new
  end

  it "Flickr should return meta data" do
    @parser.parse('http://flic.kr/p/bBqyXJ')[:meta]["title"].should be_a String
  end
end
