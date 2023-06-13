class Admin::RegistersController < ApplicationController
  
  def new
    @register = Register.new
  end
  
  def create
    @register = Register.new(register_params)
    @register.save
    redirect_to admin_registers_path
  end
  
  def index
    @registers = Register.all
  end 
  
  def show
    @register = Register.find(params[:id])
  end
  
  def edit
    @register = Register.find(params[:id])
  end
  
  def update
    @register = Register.find(params[:id])
    @register.update(register_params)
    redirect_to admin_register_path(@register)
  end
  
  private
  def register_params
    params.require(:register).permit(:reference_number, :name, :detail, :is_deleted)
  end
  
  
end

