module SourceImage
  class Parser

    def parse(url)

    end

    def patterns
     @patterns ||= [
      [ /yfrog\.com/, :yfrog ]
     ]
    end

    # yFROG
    def yfrog(url)
      puts url
    end
  end
end
