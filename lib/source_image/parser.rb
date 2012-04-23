require 'open-uri'

module SourceImage
  # Main parser class
  class Parser
    def parse(url)
      pics = []
      patterns.each do |pattern|
        if url.match pattern[0]
          process = (self.send pattern[1], url)
          pics += process if not process.empty?
        end
      end
      pics.compact.uniq
    end

    def patterns
     @patterns ||= [
      [ /yfrog\.com/, :yfrog ]
     ]
    end

    # yFROG
    def yfrog(url)
      require 'nokogiri'
      out = []
      match = url.match /\/([^\/]+)$/
      if match
        yfrog_api_url = 'http://yfrog.com/api/xmlInfo?path=' + match[1]
        doc = Nokogiri::XML(open(yfrog_api_url))
        if doc.css("links video_embed").count < 1 and doc.css("links image_link").count > 0
          out << doc.css("links image_link").first.text
        end
      end
      out
    end
  end
end
