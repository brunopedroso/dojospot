class DojoSessionsController < ApplicationController

	before_filter :login_required, :except=>[:index, :show]
	before_filter :require_propose_priv, :only=>[:new, :create, :edit, :update]

	def require_propose_priv
		if !current_user.has_propose_priv?
			redirect_to login_path
		end
	end

	def index
		@dojo_sessions = DojoSession.find_proposed_sessions
	end

	def new
		@dojo_session = DojoSession.new
	end
	
	def show
		@dojo_session = DojoSession.find(params[:id])
	end
	
	def create
		
		dojo_session = DojoSession.new(params[:dojo_session])
		
		# associates as confirmed user
		dojo_session.confirmed_users << current_user
		
		dojo_session.save
		redirect_to dojo_sessions_path
	end

	def confirm_presence
		dojo_session = DojoSession.find params[:id].to_i
		unless dojo_session.confirmed_users.include?(current_user)
			dojo_session.confirmed_users << current_user
			dojo_session.save
		end
		redirect_to dojo_sessions_path
	end
	
	def unconfirm_presence
		dojo_session = DojoSession.find params[:id].to_i
		dojo_session.confirmed_users.delete current_user
		dojo_session.save
		redirect_to dojo_sessions_path
	end

	def edit
		@dojo_session = DojoSession.find(params[:id].to_i)
	end
	
	def update
		session = DojoSession.find params[:id].to_i
		session.update_attributes(params[:dojo_session])
		session.save
		redirect_to dojo_sessions_path
	end
	
end
