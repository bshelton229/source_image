require 'source_image/version'
require 'source_image/processors'

module SourceImage
  autoload :Parser,   'source_image/parser'

  # Convenience helper method
  def self.parse(url)
    self::Parser.new.parse(url)
  end
end
