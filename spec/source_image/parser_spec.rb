require 'spec_helper'

describe SourceImage::Parser do
  describe "#parse should parse media URLs" do
    it "Should be able to parse a yfrog url" do
      parser = SourceImage::Parser.new
      parser.parse('http://yfrog.com/nwxq48p').should eq('http://img860.imageshack.us/img860/1516/xq48.png')
    end
  end
end
