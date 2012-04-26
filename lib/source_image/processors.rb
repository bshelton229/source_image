module SourceImage
  module Processors
    # Default processors
    @@processors = [
      {
        :name => 'yfrog',
        :pattern => /yfrog\.com/,
        :processor => :yfrog
      },
      {
        :name => 'owly',
        :pattern => /ow\.ly\/i\//,
        :processor => :owly
      },
      {
        :name => 'twitpic',
        :pattern => /twitpic\.com/,
        :processor => :twitpic
      },
      {
        :name => 'whosay',
        :pattern => /say\.ly/,
        :processor => :whosay
      },
      {
        :name => 'instagram',
        :pattern => /instagr\.am/,
        :processor => :instagram
      },
      {
        :name => 'lockerz',
        :pattern => /lockerz\.com/,
        :processor => :lockerz
      }
    ]

    # Getter method
    def processors
      @@processors
    end

    # Setter method
    def add(processor)
      @@processors.push processor
    end
  end
end
