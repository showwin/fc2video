# fc2video
The fc2video gem can be used for managing videos of http://video.fc2.com.  
You can easily scrape videos' metadata.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fc2video'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fc2video

## Usage

```ruby
# scrape newest 100 general(not adult) videos
videos = Fc2video::Scraper.start(:general, 100, 0)
videos.each do |video|
  video.title
  #=> return: 'a excellent movie'

  video.duration
  # format: 'mmm:ss' (not 'hh:mm:ss')
  #=> return: '117:28', '23:11'

  video.url
  #=> return: 'http://video.fc2.com/en/content/foo'

  video.image_url
  # url of thumbnail
  #=> return: 'http://vip.video00000-thumbnail.fc2.com/up/thumb/foo/bar'

  video.views
  # how many times the video was watched.
  #=> return: 58818

  video.bookmarks
  # how many times the video was bookmarked.
  #=> return: 118

  video.adult?
  # return true if it is adult video.
  #=> return: true or false

  video.status
  # return: :all or :premium or :sale

  video.for_all?
  # all user can watch for free.
  #=> return: true or false

  video.for_premium?
  # only VIP user can watch premium videos.
  #=> return: true or false

  video.for_sale?
  # pay to watch video
  #=> return: true or false
end
```

### Scraping Options
* type (`:general` or `:adult`)
* size (Fixnum)
* offset (Fixnum)

The number of `size` and `offset` is better for multiples of 50. That's why there are 50 videos information in every page we scrape.

```ruby
#Fc2video::Scraper.start(:type, :size, :offset)
Fc2video::Scraper.start(:adult, 1000, 500)
```

### Scraping Speed
It takes 20~30sec for scraping 1000 videos.

## Contributing
Bug reports and pull requests are welcome.
