require 'sinatra'
require 'json'

module ImagineBreaker
  class Server < Sinatra::Base

    set :root, "#{File.dirname(__FILE__)}/../../"

    get '/' do
      redirect '/index.html'
    end

    post '/images' do
      content_type :json
      json = JSON.parse request.body.read

      image = Image.new(json['url'], json['tags'].split(","))
      image.save
      image.to_json
    end

    get '/images' do
      content_type :json

      images = Image.all
      images.to_json
    end

    get %r{/images/(.+)$} do
      content_type :json

      Image.where(params[:captures].first.split("/")).to_json
    end

  end
end
