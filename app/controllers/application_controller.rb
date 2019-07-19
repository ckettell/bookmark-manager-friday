require 'sinatra/base'
require 'sinatra/flash'
require './app/models/Bookmark.rb'
require './app/models/database_connection_setup'
require 'uri'

class ApplicationManager < Sinatra::Base

    enable :sessions, :method_override
    register Sinatra::Flash
    set :views, "app/views"
    set :public_dir, "public"

  get '/'  do
    erb(:index)
  end

  get '/bookmarks' do
    @bookmark_list = Bookmark.list
    erb(:bookmarks)
  end

  get '/create-bookmarks' do
    erb (:create_bookmarks)
  end

  post '/bookmarks-added' do
    flash[:notice] = "You must submit a valid URL." unless Bookmark.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  # post '/bookmarks' do
  #   flash[:notice] = "You must submit a valid URL." unless Bookmark.create(url: params[:url], title: params[:title])
  #   redirect('/bookmarks')
  # end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])
    erb (:update_bookmarks)
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], title: params[:title], url: params[:url])
    redirect ('/bookmarks')
  end

  run! if app_file == $0

end
#hi
