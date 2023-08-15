class Admin::RegistersController < ApplicationController
  
before_action :authenticate_admin!, except: [:top]

include  RegistersHelper

  def new
    @register = Register.new
  end
  
  def create
    @register = Register.new(register_params)
    if @register.save
      flash[:notice] = "台帳を作成しました。"
      redirect_to admin_registers_path
    else
      flash.now[:alert] = "⚠台帳の作成に失敗しました。"
      render :new
    end
  end
  
  def index
    @registers = Register.all.page(params[:page])
    
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
    @registers = @registers.order("#{admin_registers_sort_column} #{admin_registers_sort_direction}").page(params[:page])
  end 
  
  def show
    @register = Register.find(params[:id])
  end
  
  def edit
    @register = Register.find(params[:id])
  end
  
  def update
    @register = Register.find(params[:id])
    if @register.update(register_params)
      flash[:notice] = "台帳情報を更新しました。"
      redirect_to admin_register_path(@register)
    else
      flash.now[:alert] = "⚠台帳の更新に失敗しました。"
      render :edit

    end
  end
  
  private
  def register_params
    params.require(:register).permit(:reference_number, :name, :detail, :is_deleted)
  end
  
  
end

