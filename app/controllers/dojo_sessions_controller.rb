class DojoSessionsController < ApplicationController

	def new
		@dojo_session = DojoSession.new
	end
	
	def create
		redirect_to '/'
	end
	
end
