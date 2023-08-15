class User::Equipment::CommentsController < ApplicationController


  def create
    @equipment = Equipment.find(params[:equipment_id])
    comment = current_user.comments.new(comment_params)
    comment.equipment_id = @equipment.id
    if comment.save
      @register_id = params[:register_id]
      flash[:notice] = "コメントをしました。"
      redirect_to user_register_equipment_path(@register_id,@equipment)
    else
      @register_id = params[:register_id]
      flash[:alert] = "⚠ コメントに失敗しました。"
      redirect_to user_register_equipment_path(@register_id,@equipment)
    end
  end
  
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
