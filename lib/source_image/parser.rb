require 'open-uri'
require 'uri'
require 'net/http'
require 'url_hunter'
require 'json'

module SourceImage
  # Main parser class
  class Parser
    # Load the processors from source_image/processors
    extend SourceImage::Processors

    # Load the external processors
    def processors
      self.class.processors
    end

    # Parse a URL and return an array or pictures found
    # or an empty array
    def parse(url)
      processors.each do |processor|
        patterns = processor[:pattern].kind_of?(Array) ? processor[:pattern] : [processor[:pattern]]
        patterns.each do |pattern|
          if url =~ pattern
            process = (self.send processor[:processor], url)
            if not process.empty?
              return {
                :media => process[:media],
                :meta => process[:meta],
                :processor => processor[:name],
                :url => url
              }
            end
          end
        end
      end
      false
    end

    # Yfrog image parser
    def yfrog(url)
      out = {
        :media => [],
        :meta => nil
      }
      begin
        data = JSON.parse(open("http://www.yfrog.com/api/oembed?url=#{URI.escape(url)}").read)
      rescue Exception => e
        return out
      end
      # Bullocks
      if data["type"] and data["type"] == 'image' and data["url"]
        out[:media] << data["url"]
      end
      out
    end

    # Ow.ly image parser
    # Hootsuite images seem to live in ow.ly/i/#{id} urls
    # and appear to consistently reoslve to
    # http://static.ow.ly/photos/normal/#{id}.jpg
    def owly(url)
      out = {
        :media => [],
        :meta => nil
      }
      match = url.match /\/([^\/]+)$/
      if match
        out[:media] << "http://static.ow.ly/photos/normal/#{match[1]}.jpg"
      end
      out
    end

    # Twitpic parser
    def twitpic(url)
      out = {
        :media => [],
        :meta => nil
      }
      # Pull the ID from the twitpic URL
      match = url.match /\/([^\/]+)$/
      if match
        out[:media] << "http://twitpic.com/show/full/#{match[1]}"
      end
      out
    end

    # Whosay
    def whosay(url)
      out = {
        :media => [],
        :meta => nil
      }
      expanded_url = UrlHunter.resolve(url)
      search = expanded_url.match /whosay.*\/photos\/(\d+)$/
      if search
        out[:media] << "http://media.whosay.com/#{search[1]}/#{search[1]}_la.jpg"
      end
      out
    end

    # Instagram parser
    # Use the instagram oembed API
    def instagram(url)
      out = {
        :media => [],
        :meta => nil
      }
      begin
        data = open("http://api.instagram.com/oembed?url=#{URI.escape(url)}").read
        parsed_data = JSON.parse data
        out[:meta] = parsed_data
        out[:media] << parsed_data["url"] if parsed_data["url"]
      rescue Exception => e
      end
      out
    end

    # Lockerz Parser
    def lockerz(url)
      out = {
        :media => [],
        :meta => nil
      }
      out[:media] << "http://api.plixi.com/api/tpapi.svc/imagefromurl?url=#{URI.escape(url)}&size=big"
      out
    end

    def flickr(url)
      out = {
        :media => [],
        :meta => nil
      }
      # Use the oembed API
      begin
        data = JSON.parse(open("http://www.flickr.com/services/oembed.json/?url=#{URI.escape(url)}").read)
      rescue Exception => e
        puts e
        return out
      end
      if data["type"] and data["type"] == 'photo' and (data["url"] || data["thumbnail_url"])
        out[:meta] = data
        out[:media] << data["url"] || data["thumbnail_url"]
      end
      out
    end
  end
end
