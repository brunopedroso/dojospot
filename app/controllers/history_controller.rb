class HistoryController < ApplicationController
	
	def index
		@dojo_sessions = DojoSession.find(:all, ["date < ?", Date.today], :order=>"date desc")
	end
	
end
