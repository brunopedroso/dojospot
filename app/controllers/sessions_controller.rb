class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      flash[:notice] = t('messages.login_ok')
      redirect_to_target_or_default(root_url)
    else
      flash.now[:error] = t('messages.login_nok')
      render :action => 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = t('messages.logoff')
    redirect_to root_url
  end
end
