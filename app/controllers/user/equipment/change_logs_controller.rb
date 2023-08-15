class User::Equipment::ChangeLogsController < ApplicationController
  
include User::Equipment::ChangeLogsHelper
  
before_action :authenticate_user!, except: [:top]

  def index
    # 画面移行用
    @equipment_id = params[:equipment_id]
    @register_id = params[:register_id]
    # 機器情報
    @equipment = Equipment.find(params[:equipment_id])
    # ChangeLogから機器のlogの取得
    @change_logs = ChangeLog.where(equipment_id: @equipment.id)
    # 抽出
    if params[:search_reference_number]
      @change_logs = @change_logs.search_reference_number(params[:search_reference_number])
    end
    if params[:search_introduction]
      @change_logs = @change_logs.search_introduction(params[:search_introduction])
    end
    if params[:search_name]
        @change_logs = @change_logs.search_name(params[:search_name])
    end
    if params[:search_model]
      @change_logs = @change_logs.search_model(params[:search_model])
    end
    if params[:search_location]
      @change_logs = @change_logs.search_location(params[:search_location])
    end
    if params[:search_notes]
      @change_logs = @change_logs.search_notes(params[:search_notes])
    end
    if params[:search_date]
      @change_logs = @change_logs.search_date(params[:search_date])
    end
    if params[:search_user]
      @change_logs = @change_logs.where(user_id: User.where('name LIKE ?', "%#{params[:search_user]}%"))
    end
    if params[:start_date] != "" &&  !params[:start_date].nil?
      start_date = DateTime.parse(params[:start_date]+"+0900")
      @change_logs = @change_logs.where("changed_at >= ?", start_date)
    end
    if params[:end_date] != "" &&  !params[:end_date].nil?
      end_date = DateTime.parse(params[:end_date]+"+0900")
      arr = params[:end_date].split(":")
      arr[2] = arr[2].to_i + 1
      end_date = DateTime.parse(arr.join(":") + "+0900")
      @change_logs = @change_logs.where("changed_at <= ?", end_date)
    end
    
    # ソート
    @change_logs = @change_logs.order("#{change_logs_sort_column} #{change_logs_sort_direction}").page(params[:page])
  end
  
end