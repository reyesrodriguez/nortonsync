class SongsController < ApplicationController
	
 require 'will_paginate/array'

 def index

 	@fav = FavoriteSong.all
 		if params[:tag]
 			@songs = Song.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 20)
 			
 		else if params[:search]
 			@songs = Song.search(params[:search]).paginate(:page => params[:page], :per_page => 20)
 		else
 			@songs = Song.paginate(:page => params[:page], :per_page => 20)
 	
 		end
 		
 		end	

 end

 def import 
 	if params[:file].present?
 	Song.import(params[:file])
	redirect_to songs_path, notice: "Songs Imported!"
	else 
    flash[:error] = "No File Chosen"
    redirect_to songs_path
end
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

 def favorite
 	@song = Song.find_by_id params[:id]
    type = params[:type]
    if type == "favorite"
      current_user.favorites << @song
      redirect_to :back, notice: 'You favorited #{@song.title}'

    elsif type == "unfavorite"
      current_user.favorites.delete(@song)
      redirect_to :back, notice: 'Unfavorited #{@song.title}'

    else
      # Type missing, nothing happens
      redirect_to :back, notice: 'Nothing happened.'
    end
end

 private
 	def song_params
 		params.require(:song).permit(:title, :artist, :writer, :publisher, :theme, :page, :publishing, :mood, :genre, :audiourl, :all_tags, :type)
 	end



end
