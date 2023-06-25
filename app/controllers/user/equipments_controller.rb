class User::EquipmentsController < ApplicationController

  def new
    @equipment = Equipment.new
    @equipment.register_id = params[:register_id]
    @registerId = params[:register_id]
  end
  
  def create
    @equipment = Equipment.new(equipment_params)
    @registerId = params[:register_id]
    @equipment.save
    redirect_to user_register_equipment_path(@registerId,@equipment)
  end
  
  def index
    @register = Register.find(params[:register_id])
    @equipments = @register.equipments
  end
  
  def show
    @equipment = Equipment.find(params[:id])
    @registerId = params[:register_id]
    @comment = Comment.new
  end
  
  def edit
    @equipment = Equipment.find(params[:id])
    @registerId = params[:register_id]
  end
  
  def update
    @equipment = Equipment.find(params[:id])
    @equipment.update(equipment_params)
    @registerId = params[:register_id]
    redirect_to user_register_equipment_path(@registerId,@equipment)
  end
  
  
  private
  def equipment_params
    params.require(:equipment).permit(:reference_number, :introduction, 
    :location, :name, :model, :date, :notes, :is_deleted, :image, :register_id)
  end
  
end
