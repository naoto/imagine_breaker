require "imagine_breaker/version"

module ImagineBreaker
  # Your code goes here...
  
  require 'imagine_breaker/server'
  require 'imagine_breaker/image'

  def self.run(options)
    Server.run!
  end

end
