class SongsController < ApplicationController
	
 require 'will_paginate/array'

 def index
 	if params[:search]
 		@songs = Song.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
 		# @songs = Song.tagged_with(params[:tag])
 	else 
 		@songs = Song.paginate(:page => params[:page], :per_page => 10)

	end
 end

 def import 
 	Song.import(params[:file])
	redirect_to songs_path, notice: "Songs Imported!"
end

 def show 
 	@song = Song.find_by_id params[:id]

 	if @song.blank?
 		redirect_to songs_path, :alert => 'song not found'
 	end
end

 def new
 	@song = Song.new
 end

 def create 
 	@song = Song.new(song_params)
 	if @song.save
 		redirect_to :action => 'show', :id => @song.id
 	else 
 		render :action => 'new'
 	end
 end

  def edit
    @song = Song.find params[:id]
  end

 def update
 	@song = Song.find(params[:id])
 	if @song.update(song_params)
 		redirect_to :action => 'show', :id => @song.id
 	end
 end

 def destroy
 	@song = Song.find params[:id]
 	@song.destroy
 	
 	flash[:alert]="Song '#{@song.title}' by '#{@song.artist}' was deleted"

 	redirect_to songs_path
 end

 private
 	def song_params
 		params.require(:song).permit(:title, :artist, :writer, :publisher, :theme, :page, :publishing, :mood, :genre, :audiourl, :all_tags)
 	end



end
