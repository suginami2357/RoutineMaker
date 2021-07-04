class SessionsController < ApplicationController
  def login
  end 

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      
      log_in(@user)
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      
      flash[:success] = "ログインしました。"
      redirect_to controller: :routines, action: :top
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードが一致しません。'
      @email = params[:session][:email];
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:danger] = "ログアウトしました。"
    redirect_to root_url
  end
end