require 'spec_helper'

describe Fc2video do
  it 'has a version number' do
    expect(Fc2video::VERSION).not_to be nil
  end

  it 'scrape general videos' do
    videos = Fc2video::Scraper.start(:general, 50, 0)
    video = videos.last
    expect(video.title.class).to eq(String)
    expect(video.duration.class).to eq(String)
    expect(video.duration.include?(':')).to be_truthy
    expect(video.url.include?('http://video.fc2.com')).to be_truthy
    expect(video.image_url.include?('thumbnail.fc2.com')).to be_truthy
    expect(video.views.class).to eq(Fixnum)
    expect(video.bookmarks.class).to eq(Fixnum)
    expect(video.adult?).to be_falsey
    expect([:all, :premium, :sale].include?(video.status)).to be_truthy
    expect(videos.size).to eq(50)
  end

  it 'scrape adult videos' do
    videos = Fc2video::Scraper.start(:adult, 100, 50)
    video = videos.last
    expect(video.title.class).to eq(String)
    expect(video.duration.class).to eq(String)
    expect(video.duration.include?(':')).to be_truthy
    expect(video.url.include?('http://video.fc2.com')).to be_truthy
    expect(video.image_url.include?('thumbnail.fc2.com')).to be_truthy
    expect(video.views.class).to eq(Fixnum)
    expect(video.bookmarks.class).to eq(Fixnum)
    expect(video.adult?).to be_truthy
    expect([:all, :premium, :sale].include?(video.status)).to be_truthy
    expect(videos.size).to eq(100)
  end

  describe '#adult?' do
    it 'should return true' do
      video = Fc2video::Video.new(adult: true)
      expect(video.adult?).to be_truthy
    end

    it 'should return false' do
      video = Fc2video::Video.new(adult: false)
      expect(video.adult?).to be_falsey
    end
  end

  describe '#for_all?' do
    it 'shuold return true' do
      video = Fc2video::Video.new(status: :all)
      expect(video.for_all?).to be_truthy
    end

    it 'should return false' do
      video = Fc2video::Video.new(status: :premium)
      expect(video.for_all?).to be_falsey
      video = Fc2video::Video.new(status: :sale)
      expect(video.for_all?).to be_falsey
    end
  end

  describe '#for_premium?' do
    it 'should return true' do
      video = Fc2video::Video.new(status: :premium)
      expect(video.for_premium?).to be_truthy
    end

    it 'should return false' do
      video = Fc2video::Video.new(status: :all)
      expect(video.for_premium?).to be_falsey
      video = Fc2video::Video.new(status: :sale)
      expect(video.for_premium?).to be_falsey
    end
  end

  describe '#for_sale?' do
    it 'should return true' do
      video = Fc2video::Video.new(status: :sale)
      expect(video.for_sale?).to be_truthy
    end

    it 'should return false' do
      video = Fc2video::Video.new(status: :all)
      expect(video.for_sale?).to be_falsey
      video = Fc2video::Video.new(status: :premium)
      expect(video.for_sale?).to be_falsey
    end
  end
end
