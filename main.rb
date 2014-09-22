require 'sinatra'
require 'sinatra/reloader' if development?
require 'pp'
require_relative 'mec.rb'
require_relative 'yaml_record'

# Recieve and post user poem
class PPLogQueue < Sinatra::Base
  include PoemPoster

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    @posts = Post.all
    erb :index
  end

  post '/create' do
    body = params[:body]
    Post.create(body: body)
    redirect '/'
  end

  post '/post' do
    poem = Post.find_by_id(params[:id])
    post_poem poem.body
    poem.destroy
  end
end
