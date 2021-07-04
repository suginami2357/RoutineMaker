class User < ApplicationRecord
  attr_accessor :remember_token
  
  #saveをする前に動作する
  before_save { self.email = email.downcase }
  
  # \A … 文字列の先頭にマッチ
  # [\w\-] … 「a-zA-Z0-9_」と「-」にマッチ
  # + … 一回以上繰り返す
  # \z … 文字列の末尾にマッチ
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    length: { maximum: 255 }, 
                    uniqueness: true, 
                    format: { with: VALID_EMAIL_REGEX }
                      
  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  validates :password, presence: true,
                       length: { minimum: 8 },
                       format: { with: VALID_PASSWORD_REGEX }
                         
  has_secure_password
  
  # ◆ログイン状態の保持方法
  
  # cookies     ：記憶トークン, ユーザーID(ハッシュ化)
  # データベース：ユーザーID(ハッシュ化), 記憶トークン(ハッシュ化)
  
  # 1. cookiesをサーバーに渡す
  # 2. ユーザーID(ハッシュ化)でデータベースを検索
  # 3. 一致したユーザーから記憶トークン(ハッシュ化)を取得
  # 4. cookiesの記憶トークンをハッシュ化して値が一致した場合、認証完了！
  
  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
    # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    #updateメソッド　ただしバリデーションを無視する
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
    # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    
    # BCrypt::Password
    # => BCryptモジュールの中で定義されたPasswordクラス
    
    # is_password?
    # => Passwordクラスで下記の定義がされている
    # 要約すると ハッシュ化して比較
    
    # def ==(secret)
    #  super(BCrypt::Engine.hash_secret(secret, @salt))
    # end
    
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
    # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end