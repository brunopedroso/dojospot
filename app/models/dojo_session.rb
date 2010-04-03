class DojoSession < ActiveRecord::Base
	def self.find_proposed_sessions
		self.find(:all, :conditions=>["date >= ?", Date.today])
	end
end