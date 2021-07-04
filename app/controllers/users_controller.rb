class UsersController < ApplicationController
  def home
    if logged_in?
      redirect_to controller: :routines, action: :home;
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "登録が完了しました。"
      redirect_to controller: :routines, action: :home;
    else
      flash.now[:danger] = @user.errors.full_messages.first
      render action: :new
    end
  end
  
  def edit
    @user = User.find(params[:id]) # DBから既存のものを取得
  end
  
  def update
    @user = User.find_by(email: params[:email])
    
    if @user && !!@user.authenticate(params[:password])
      flash[:notice] = "ログインしました。"
      redirect_to controller: :routines, action: :home;
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが一致しません。"
      render action: :login
    end
  end
  
  private
    # ストロングパラメータ
    def user_params
      params.require(:user).permit(:email, :password)
    end
end