class DojoSessionsController < ApplicationController

	before_filter :login_required

	def new
		@dojo_session = DojoSession.new
	end
	
	def create
		dojo_session = DojoSession.new(params[:dojo_session])
		
		# já associa como confirmado
		dojo_session.confirmed_users << current_user
		
		dojo_session.save
		redirect_to '/'
	end

	def confirm_presence
		dojo_session = DojoSession.find params[:id].to_i
		unless dojo_session.confirmed_users.include?(current_user)
			dojo_session.confirmed_users << current_user
			dojo_session.save
		end
		redirect_to '/'
	end
	
	def unconfirm_presence
		dojo_session = DojoSession.find params[:id].to_i
		dojo_session.confirmed_users.delete current_user
		dojo_session.save
		redirect_to '/'
	end
	
end
