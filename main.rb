require 'sinatra'
require 'sinatra/reloader' if development?
require 'pp'
require 'yaml_record'

class Post < YamlRecord::Base
  properties :body
  adapter :local
  source File.expand_path('./post')
end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    @posts = Post.all
    erb :index
  end

  post '/create' do
    body = params[:body]
    Post.create(:body => body)
    redirect '/'
  end

end
