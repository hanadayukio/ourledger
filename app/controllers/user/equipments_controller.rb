class User::EquipmentsController < ApplicationController
  
before_action :authenticate_user!, except: [:top]
before_action :require_edit_permission, only: [:new, :edit, :update]

require 'csv'

include User::EquipmentsHelper

  def new
    @equipment = Equipment.new
    @equipment.register_id = params[:register_id]
    @register_id = params[:register_id]
  end
  
  def create
    @register_id = params[:register_id]
    if params[:equipment]
      @equipment = Equipment.new(equipment_params)
      if @equipment.save
        flash[:notice] = "機器を登録しました。"
        redirect_to user_register_equipment_path(@register_id,@equipment)
      else
        flash.now[:alert] = "⚠ 機器の登録に失敗しました。"
        render :new
      end
    else
      error_message = Equipment.import(params[:file], @register_id)
      unless error_message.empty?
        flash[:alert] = error_message
      else
        flash[:notice] = "CSVデータをインポートしました。"
      end
      redirect_to user_register_equipments_path(@register_id)
    end
  end
  
  def index
    @register = Register.find(params[:register_id])
    # 通常時
    @equipments = @register.equipments
    
    # 抽出
    if params[:search_reference_number]
      @equipments = @equipments.search_reference_number(params[:search_reference_number])
    end
    if params[:search_introduction]
      @equipments = @equipments.search_introduction(params[:search_introduction])
    end
    if params[:search_name]
        @equipments = @equipments.search_name(params[:search_name])
    end
    if params[:search_model]
      @equipments = @equipments.search_model(params[:search_model])
    end
    if params[:search_location]
      @equipments = @equipments.search_location(params[:search_location])
    end
    if params[:search_date]
      @equipments = @equipments.search_date(params[:search_date])
    end

    # ソート
    @equipments = @equipments.order("#{equipments_sort_column} #{equipments_sort_direction}").page(params[:page])

#CSV出力用 
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_equipments_csv(@equipments)
      end
    end
  end
  
  
  def send_equipments_csv(equipments)
    csv_data = CSV.generate do |csv|
      header = %w(reference_number introduction location name model date notes is_deleted)
      csv << header
      equipments.each do |equipment|
        values = [equipment.reference_number,equipment.introduction,equipment.location,
          equipment.name,equipment.model,equipment.date,equipment.notes,equipment.is_deleted]
        csv << values
      end
    end
      send_data(csv_data, filename: "#{@register.name} 機器一覧.csv")
  end
  
  
  def show
    @equipment = Equipment.find(params[:id])
    @register_id = params[:register_id]
    @comment = Comment.new
  end
  
  def edit
    @equipment = Equipment.find(params[:id])
    @register_id = params[:register_id]
  end

  def update
    @equipment = Equipment.find(params[:id])
    # 変更前の取得
    old_date = @equipment
    @register_id = params[:register_id]
    begin
      if @equipment.update(equipment_params)
      # 変更後の取得
        new_date = Equipment.find(params[:id])
        # 変更前後の比較
        change_log_params = {
          equipment_id: @equipment.id,
          user_id: current_user.id,
          reference_number: old_date.reference_number != new_date.reference_number ? old_date.reference_number : new_date.reference_number,
          introduction: old_date.introduction != new_date.introduction ? old_date.introduction : new_date.introduction,
          location: old_date.location != new_date.location ? old_date.location : new_date.location,
          name: old_date.name != new_date.name ? old_date.name : new_date.name,
          model: old_date.model != new_date.model ? old_date.model : new_date.model,
          date: old_date.date != new_date.date ? old_date.date : new_date.date,
          notes: old_date.notes != new_date.notes ? old_date.notes : new_date.notes,
          changed_at: Time.now
        }
        change_log = ChangeLog.new(change_log_params)
        change_log.save!
        flash[:notice] = "機器情報を更新しました。"
        redirect_to user_register_equipment_path(@register_id, @equipment)
      else
        flash.now[:alert] = "⚠ 機器情報の更新に失敗しました。"
        render :edit
      end
    rescue ActiveRecord::StaleObjectError
      flash.now[:alert] = "⚠ 競合しています。機器情報の更新に失敗しました、"
      render :edit
    end
  end
  
  def import
    Task.import(params[:file])
    redirect_to root_url
  end


  private
# 編集権限の有無確認
  def require_edit_permission
    unless !current_user.edit_permission
      flash[:alert] = "⚠ 編集権限がありません。"
      redirect_to user_home_page_path
    end
  end
  
  def change_log_params
    params.require(:equipment).permit(:equipment_id, :user_id, :reference_number, :introduction, 
      :location, :name, :model, :date, :notes, :changed_at)
  end
  
  def equipment_params
    params.require(:equipment).permit(:reference_number, :introduction, 
      :location, :name, :model, :date, :notes, :is_deleted, :image, :register_id, :lock_version)
  end

end
