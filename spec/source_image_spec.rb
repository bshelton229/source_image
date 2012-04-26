require 'spec_helper'

describe SourceImage do
  it "Should have a #parse method as a convenience for ::Parser" do
    SourceImage.parse('http://www.apple.com').should be_false
  end
end
