require 'redis'

module ImagineBreaker
  class Image

    def self.all
      Image.new.find(["no_keyword"])
    end

    def self.where(tags)
      Image.new.find(tags)
    end

    def initialize(url = nil, tags = nil)
      @url = url
      @tags = tags
    end

    def save
      redis.sadd "no_keyword", @url
      redis.sadd @url, @tags
      @tags.each do |tag|
        redis.sadd tag, @url
      end
    end

    def find(tags)
      images = []
      redis.sinter(tags).each do |url|
        images << Image.new(url, redis.sinter(url).to_a)
      end
      images
    end

    def to_json(args = nil)
      {url: @url, tags: @tags}.to_json
    end

    private
      def redis
        @@redis ||= Redis.new(:url => ENV['REDISTOGO_URL'])
      end

  end
end
