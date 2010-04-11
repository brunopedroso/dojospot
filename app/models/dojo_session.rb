class DojoSession < ActiveRecord::Base
	
	has_and_belongs_to_many :confirmed_users, :class_name=>"User", :join_table => "confirmations", :foreign_key => "dojo_session_id"
	
	def self.find_proposed_sessions
		self.find(:all, :conditions=>["date >= ?", Date.today], :order=>'date asc, id desc')
	end
	
end