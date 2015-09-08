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
videos = Fc2video.scrape(size: 100, type: :general, order: :new)
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

  video.premium?
  # only VIP user can watch premium videos.
  #=> return: true or false

  video.available?
  # videos on FC2Video are deleted frequently.
  # you can check whether the video still exists.
  #=> return: true or false
end


# check existence of the video which was scraped previously
# and get current number of bookmarks
video = Fc2video.new('http://video.fc2.com/en/content/previously_got_url')
current_bookmarks = video.bookmarks if video.available?
```

### Scraping Options
* size (integer)
* type (`:general` or `:adult`)
* order (`:new` or `:old`)

```ruby
# scrape oldest 1000 adult videos
Fc2video.scrape(size: 1000, type: :adult, order: :old)
```

## Contributing
Bug reports and pull requests are welcome.
