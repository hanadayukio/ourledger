class User::CommentsController < ApplicationController
  
  def create
    @equipment = Equipment.find(params[:equipment_id])
    comment = current_user.comments.new(comment_params)
    comment.equipment_id = @equipment.id
    comment.save
    @registerId = params[:register_id]
    redirect_to user_register_equipment_path(@registerId,@equipment)
  end
  
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
