class DojoSessionsController < ApplicationController

	def new
		unless logged_in?
			redirect_to '/' 
			return
		end
		@dojo_session = DojoSession.new
	end
	
	def create
		dojo_session = DojoSession.new(params[:dojo_session])
		dojo_session.save
		redirect_to '/'
	end
	
end
