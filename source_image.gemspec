# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "source_image/version"

Gem::Specification.new do |s|
  s.name        = "source_image"
  s.version     = SourceImage::VERSION
  s.authors     = ["Bryan Shelton"]
  s.email       = ["bryan@sheltonopensolutions.com"]
  s.homepage    = ""
  s.summary     = %q{Source image finder from social media links}
  s.description = %q{A quick library to find source images from social media image URLs}

  s.rubyforge_project = "source_image"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec'
end
