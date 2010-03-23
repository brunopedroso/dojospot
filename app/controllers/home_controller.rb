class HomeController < ApplicationController

	def index
		@dojo_sessions = DojoSession.find_proposed_sessions
	end
	
end
