class DojoSessionsController < ApplicationController

	def new
		@dojo_session = DojoSession.new
	end
	
	def create
		dojo_session = DojoSession.new(params[:dojo_session])
		dojo_session.save
		redirect_to '/'
	end
	
end
