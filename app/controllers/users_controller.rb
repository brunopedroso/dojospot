class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

	def edit
		@user = User.find(session[:user_id])
	end
	
	def update
		@user = User.find(params[:id])
		@user.update_attributes(params[:user])
		@user.save

		#notice: we don't handle the case where user can't be updated...
		
		flash[:notice] = "Your profile has been successfully updated!"
		redirect_to(edit_profile_path)
	end

end
