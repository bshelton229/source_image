require 'spec_helper'

describe SourceImage::Parser do
  describe "#parse should parse media URLs" do
    before :each do
      @parser = SourceImage::Parser.new
    end

    it "Should be able to parse a yfrog url" do
      @parser.parse('http://yfrog.com/nwxq48p').should eq(['http://img860.imageshack.us/img860/1516/xq48.png'])
    end

    it "Should be able to parse ow.ly image pages, especially if they're pictures of the beautiful lake Mendota" do
      @parser.parse('http://ow.ly/i/mSGX').should eq(['http://static.ow.ly/photos/normal/mSGX.jpg'])
    end

    it "Should be able to parse twitpic urls" do
      @parser.parse('http://twitpic.com/99sm0u').should eq(['http://twitpic.com/show/full/99sm0u'])
    end

    it "Should be able to parse say.ly photos" do
      @parser.parse('http://say.ly/FIF38Zn').should eq(["http://media.whosay.com/162434/162434_la.jpg"])
    end

    it "Sould return an empty array for unsupported URLS" do
      @parser.parse('http://www.apple.com').should eq([])
    end
  end
end
