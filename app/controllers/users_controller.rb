class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create, :index]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => t("messages.thanks_for_signup")
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to edit_profile_path, :notice => t("messages.profile_successfully_updated")
    else
      render :action => 'edit'
    end
  end
  
  def index
		@users=User.all
	end
	
end
