# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
  # 退社しているかを判断するメソッド
  def user_state
  # 入力されたemailからアカウントを1件取得
  @user = User.find_by(email: params[:user][:email])
  # アカウントを取得できなかった場合、このメソッドを終了する
    return if !@user
  # 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @user.valid_password?(params[:user][:password])
    # 【処理内容3】
      if @user.is_deleted
    # 退社している場合
        flash[:alert] = "このユーザーではログインできません。"
        redirect_to new_user_session_path
      else
    # ログイン成功
      end
    else
      flash[:alert] = "パスワードが正しくありません。"
      redirect_to new_user_session_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  
  def after_sign_in_path_for(resource)
      user_home_page_path
  end
  
  def after_sign_out_path_for(resource)
      new_user_session_path
  end
  
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

end
