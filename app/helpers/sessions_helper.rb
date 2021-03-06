module SessionsHelper
    # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # ユーザーのセッションを永続的にする
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    # ◆if (user_id = session[:user_id]) の意味
    # user_id にユーザーIDのセッションを代入
    # user_id に対して真偽判定を実施
    # nilならfalse となる
    # つまり ユーザーIDのセッションの値が存在するか判定している
    
    # セッションユーザー(ブラウザを閉じていない)が存在
    if (user_id = session[:user_id])
      # @current_user = @current_user || User.find_by(id: user_id)
      @current_user ||= User.find_by(id: user_id)
      
    # クッキーユーザー(cookiesに保存)が存在
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  # #現在ログイン中のユーザーを返す（いる場合）
  # def current_user
  #   if session[:user_id]
  #     #@current_user = @current_user || User.find_by(id: session[:user_id])
  #     @current_user ||= User.find_by(id: session[:user_id])
  #   end
  # end
  
  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end
  
  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
