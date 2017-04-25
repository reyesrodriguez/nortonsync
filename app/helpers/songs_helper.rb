module SongsHelper
	def tag_links(tags)
  		tags.split(",").map{|tag| link_to tag.strip, tag_path(tag.strip) }.join(", ") 
	end

	def tag_cloud(tags, classes)
  		max = tags.sort_by(&:count).last
  		tags.each do |tag|
    	index = tag.count.to_f / max.count * (classes.size-1)
    	yield(tag, classes[index.round])
  	end
end

def fave
   @fav.each do |fave| 
   
      fave.song.title 
         if current_user 
      link_to "unfavorite", favorite_song_path(fave.song.id, type: "unfavorite"), method: :put 
      end 
     end 
   end
end
