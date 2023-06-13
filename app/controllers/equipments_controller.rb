class EquipmentsController < ApplicationController
  
  def new
    @equipment = Equipment.new
  end
  
  def create
    @equipment = Equipment.new(equipment_params)
    @equipment.save
    redirect_to admin_registers_path
  end
  
  
  private
  def equipment_params
    params.require(:equipment).permit(:reference_number, :introduction, 
    :location, :name, :date, :notes, :is_deretd, :image)
  end
  
end
