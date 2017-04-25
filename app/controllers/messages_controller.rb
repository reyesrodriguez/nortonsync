class MessagesController < ApplicationController

	def new
		@fav = FavoriteSong.all
		@song = Song.all
		@message = Message.new
	end

	def create
		@fav = FavoriteSong.all
		@song = Song.all
		@message = Message.new(message_params)

		if @message.valid?
			MessageMailer.new_message(@message).deliver
			redirect_to contact_path, notice: "Your message has been sent."
		else
			flash[:alert] = "An error occurred while delivering this message."
			render :new
		end
	end



	private

		def message_params 
			params.require(:message).permit(:name, :email, :content)

		end

	end


