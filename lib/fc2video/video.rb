module Fc2video
  class Video
    attr_reader :title, :duration, :url, :image_url, :views, :bookmarks, :status

    def initialize(params)
      @title = params[:title]
      @duration = params[:duration]
      @url = params[:url]
      @image_url = params[:image_url]
      @views = params[:views]
      @bookmarks = params[:bookmarks]
      @adult = params[:adult]
      @status = params[:status]
    end

    def adult?
      @adult
    end

    def for_all?
      @status == :all
    end

    def for_premium?
      @status == :premium
    end

    def for_sale?
      @status == :sale
    end
  end
end
