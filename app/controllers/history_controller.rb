class HistoryController < ApplicationController
	
	def index
		@dojo_sessions = DojoSession.find(:all, ["date < ?", Date.today])
	end
	
end
