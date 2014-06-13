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
      @tags.each do |tag|
        redis.sadd tag, @url
      end
    end

    def find(tags)
      puts tags.class
      redis.sinter(tags)
    end

    private
      def redis
        @@redis ||= Redis.new
      end

  end
end
