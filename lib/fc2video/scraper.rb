module Fc2video
  class Scraper
    VIDEOS_PER_PAGE = 50

    ADULT_SEARCH_URL = 'http://video.fc2.com/en/a/movie_search.php?perpage=50&page='
    NORMAL_SEARCH_URL = 'http://video.fc2.com/en/movie_search.php?perpage=50&page='
    VIDEO_PATH = '//div[@class="video_list_renew clearfix"]'
    TITLE_PATH = './div[@class="video_info_right"]/h3'
    DURATION_PATH = './div[@class="video_list_renew_thumb"]/span'
    URL_PATH = './div[@class="video_info_right"]/h3/a'
    IMAGE_URL_PATH = './div[@class="video_list_renew_thumb"]/div/a/img'
    VIEWS_PATH = './div[@class="video_info_right"]/ul/li'
    FAVS_PATH = './div[@class="video_info_right"]/ul/li'
    STATUS_PATH = './div[@class="video_info_right"]/ul/li'

    class << self
      def start(type, size, offset)
        @type = type
        @size = size
        @offset = offset

        scrape
      end

      private

      def scrape
        arr = []
        page_from.upto(page_to) do |i|
          begin
            arr.concat(scrape_page(Nokogiri::HTML(open(search_url + i.to_s))))
          rescue
            next
          end
        end
        arr
      end

      def search_url
        adult_flg ? ADULT_SEARCH_URL : NORMAL_SEARCH_URL
      end

      def adult_flg
        @type == :adult
      end

      def page_from
        (@offset / VIDEOS_PER_PAGE) + 1
      end

      def page_to
        ((@offset + @size) / VIDEOS_PER_PAGE)
      end

      def scrape_page(page)
        result = []
        VIDEOS_PER_PAGE.times do |j|
          params = scrape_params(page.xpath(VIDEO_PATH)[j])
          result << Fc2video::Video.new(params)
        end
        result
      end

      def scrape_params(elm)
        params = {}
        params[:title] = elm.xpath(TITLE_PATH).first.content
        params[:duration] = elm.xpath(DURATION_PATH).first.content
        params[:url] = elm.xpath(URL_PATH).first['href']
        params[:image_url] = elm.xpath(IMAGE_URL_PATH).first['src']
        params[:views] = elm.xpath(VIEWS_PATH)[1].content.to_i
        params[:bookmarks] = elm.xpath(FAVS_PATH)[2].content.to_i
        params[:adult] = adult_flg
        params[:status] = status_to_sym(elm.xpath(STATUS_PATH)[0].content)
        params
      end

      def status_to_sym(str)
        case str
        when 'All', 'All ★'
          :all
        when 'Premium'
          :premium
        when 'For Sale'
          :sale
        end
      end
    end
  end
end
