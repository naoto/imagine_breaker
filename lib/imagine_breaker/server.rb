require 'sinatra'
require 'json'

module ImagineBreaker
  class Server < Sinatra::Base

    set :root, "#{File.dirname(__FILE__)}/../../"

    get '/' do
      redirect '/index.html'
    end

    post '/images' do
      image = Image.new(params[:url], params[:tags].split(","))
      image.save
      redirect '/index.html'
    end

    get '/images' do
      Image.all.to_json
    end

    get %r{/images/(.+)$} do
      Image.where(params[:captures].first.split("/")).to_json
    end

  end
end
