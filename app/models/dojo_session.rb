class DojoSession < ActiveRecord::Base
	
	def self.find_proposed_sessions
		self.find(:all, :conditions=>["date >= ?", Date.today], :order=>'date asc, id desc')
	end
	
	def confirmed_users
		@confirmed_users || []
	end
	
	def confirmed_users=(users_array)
		@confirmed_users = users_array
	end
	
end