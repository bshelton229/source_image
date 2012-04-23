require 'open-uri'
require 'uri'
require 'net/http'

module SourceImage
  # Main parser class
  class Parser
    def patterns
     @patterns ||= [
      [ /yfrog\.com/, :yfrog ],
      [/ow\.ly\/i\//, :owly],
      [/twitpic\.com/, :twitpic]
     ]
    end

    # Parse a URL and return an array or pictures found
    # or an empty array
    def parse(url)
      pics = []
      patterns.each do |pattern|
        if url =~ pattern[0]
          process = (self.send pattern[1], url)
          pics += process if not process.empty?
        end
      end
      pics.compact.uniq
    end

    # Yfrog image parser
    def yfrog(url)
      require 'nokogiri'
      out = []
      match = url.match /\/([^\/]+)$/
      if match
        yfrog_api_url = 'http://yfrog.com/api/xmlInfo?path=' + match[1]
        doc = Nokogiri::XML(open(yfrog_api_url))
        # We're not interested in Videos
        if doc.css("links video_embed").count < 1 and doc.css("links image_link").count > 0
          out << doc.css("links image_link").first.text
        end
      end
      out
    end

    # Ow.ly image parser
    # Hootsuite images seem to live in ow.ly/i/#{id} urls
    # and appear to consistently reoslve to
    # http://static.ow.ly/photos/normal/#{id}.jpg
    def owly(url)
      out = []
      match = url.match /\/([^\/]+)$/
      if match
        pic = "http://static.ow.ly/photos/normal/#{match[1]}.jpg"
        # Check to see if this particular ow.ly link has a photo
        if Net::HTTP.get_response(URI.parse(pic)).code == "200"
          out << pic
        end
      end
      out
    end


    def twitpic(url)
      out = []
      # Pull the ID from the twitpic URL
      match = url.match /\/([^\/]+)$/
      if match
        out << "http://twitpic.com/show/full/#{match[1]}"
      end
      out
    end
  end
end
