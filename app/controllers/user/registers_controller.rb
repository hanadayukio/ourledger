class User::RegistersController < ApplicationController
  
before_action :authenticate_user!, except: [:top]
  
include  RegistersHelper
  
  def index
    @registers = Register.where.not(is_deleted: "true")
    
    # 抽出
    if params[:search_reference_number]
      @registers = @registers.search_reference_number(params[:search_reference_number])
    end
    if params[:search_detail]
      @registers = @registers.search_detail(params[:search_detail])
    end
    if params[:search_name]
        @registers = @registers.search_name(params[:search_name])
    end
    # ソート
    @registers = @registers.order("#{user_registers_sort_column} #{user_registers_sort_direction}").page(params[:page])
  end
  
end
