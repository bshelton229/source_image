require 'spec_helper'

describe SourceImage::Parser do
  describe "#parse should parse media URLs" do
    before :each do
      @parser = SourceImage::Parser.new
    end

    it "Should be able to parse a yfrog url" do
      @parser.parse('http://yfrog.com/nwxq48p')[:media].first.should match(/\.png$/)
    end

    it "Should be able to parse ow.ly image pages, especially if they're pictures of the beautiful lake Mendota" do
      @parser.parse('http://ow.ly/i/mSGX')[:media].should eq(['http://static.ow.ly/photos/normal/mSGX.jpg'])
    end

    it "Should be able to parse twitpic urls" do
      @parser.parse('http://twitpic.com/99sm0u')[:media].should eq(['http://twitpic.com/show/full/99sm0u'])
    end

    it "Should be able to parse say.ly photos" do
      @parser.parse('http://say.ly/FIF38Zn')[:media].should eq(["http://media.whosay.com/162434/162434_la.jpg"])
    end

    it "Should be able to parse instagr.am photos" do
      @parser.parse('http://instagr.am/p/JzXc4kD8q2/')[:media].should eq(['http://distilleryimage2.s3.amazonaws.com/038db7aa8e0a11e1abb01231381b65e3_7.jpg'])
    end

    it "Should be able to process Locker.z images" do
      @parser.parse('http://lockerz.com/s/203770946')[:media].should eq(['http://api.plixi.com/api/tpapi.svc/imagefromurl?url=http://lockerz.com/s/203770946&size=big'])
    end

    it "Should be able to process flick images" do
      @parser.parse('http://flic.kr/p/bBqyXJ')[:media].first.should include('flickr.com')
    end

    it "Sould return an empty array for unsupported URLS" do
      @parser.parse('http://www.apple.com').should be_false
    end
  end
end
