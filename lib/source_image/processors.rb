module SourceImage
  module Processors
    # Default processors
    @@processors = [
      # {
      #   :name => 'yfrog',
      #   :pattern => /yfrog\.com/,
      #   :processor => :yfrog
      # },
      {
        :name => 'owly',
        :pattern => %r(ow.ly/i/),
        :processor => :owly
      },
      {
        :name => 'twitpic',
        :pattern => %r(twitpic.com),
        :processor => :twitpic
      },
      {
        :name => 'whosay',
        :pattern => %r(say.ly),
        :processor => :whosay
      },
      {
        :name => 'instagram',
        :pattern => [ %r(instagr.am), %r(instagram.com) ],
        :processor => :instagram
      },
      {
        :name => 'lockerz',
        :pattern => %r(lockerz.com),
        :processor => :lockerz
      },
      {
        :name => 'flickr',
        :pattern => [ %r(flic.kr), %r(flickr.com) ],
        :processor => :flickr
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
