class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :"songs/index"
  end

  get '/songs/new' do
    erb :"songs/new"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @genres = @song.genres
    erb :"songs/show"
  end

  post '/songs' do
    @song = Song.create(name: params["song"]["name"])
    Artist.find_or_create_by(name: params["song"]["artist"]["name"])

    Artist.find_or_create_by(name: params["song"]["genre"]["name"])

    @song.save
  end
end
