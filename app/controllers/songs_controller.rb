class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    # binding.pry
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
    artist = Artist.find_or_create_by(name: params["artist_name"])
    genre = Genre.find_or_create_by(name: params["genre_name"])
    song = Song.create(name: params["song_name"], artist_id: artist.id)
    song.song_genres.build(genre: genre)
    song.save
    redirect "songs/#{song.slug}"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :"songs/edit"
  end

  patch '/songs/:slug' do
    song = Song.find_by_slug(params[:slug])
    song.update(name: params["song"]["name"])
    song.artist.name = params["song"]["artist"]
    song.genres.update(name: params["song"]["genre"])
    redirect "songs/#{song.slug}"
  end

  get '/songs/' do
    redirect "/songs"
  end


end
