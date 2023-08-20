class Admin::UsersController < ApplicationController
  
before_action :authenticate_admin!, except: [:top]

include UsersHelper

  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "ユーザーを作成しました。"
      redirect_to admin_users_path
    else
      flash.now[:alert] = "⚠️ユーザーの作成に失敗しました。"
      render :new
    end
  end
  
  def index
    @users = User.all
    # 抽出
    if params[:search_code]
      @users = @users.search_code(params[:search_code])
    end
    if params[:search_name]
      @users = @users.search_name(params[:search_name])
    end
    if params[:search_name_kana]
      @users = @users.search_name_kana(params[:search_name_kana])
    end
    if params[:search_email]
      @users = @users.search_email(params[:search_email])
    end
    if params[:start_date] != "" &&  !params[:start_date].nil?
      start_date = DateTime.parse(params[:start_date]+"+0900")
      @users = @users.where("created_at >= ?", start_date)
    end
    if params[:end_date] != "" &&  !params[:end_date].nil?
      end_date = DateTime.parse(params[:end_date]+"+0900")
      arr = params[:end_date].split(":")
      arr[1] = arr[1].to_i + 1
      end_date = DateTime.parse(arr.join(":") + "+0900")
      @users = @users.where("created_at <= ?", end_date)
    end
    # ソート
    @users = @users.order("#{users_sort_column} #{users_sort_direction}").page(params[:page])

    
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました。"
      redirect_to admin_user_path(@user)
    else
      flash.now[:alert] = "⚠️ユーザー情報の更新に失敗しました。"
      render :edit
    end
  end
  
  
  private
  def user_params
    params.require(:user).permit(:code, :name, :name_kana, :email,
                                 :is_deleted, :edit_permission, :password,)
  end
end
