### Social media URL source image Ruby library ###

We're using this library to find original image links from URLs in tweets.

Track down the source image file from social media links.

    SourceImage.parse 'http://yfrog.com/nwxq48p'
    => {:media=>["http://img860.imageshack.us/img860/1516/xq48.png"], :processor=>"yfrog", :url=>"http://yfrog.com/nwxq48p"}

    SourceImage.parse 'http://www.sheltonplace.com/nothing'
    => false
