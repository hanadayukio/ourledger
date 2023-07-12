class User::HomesController < ApplicationController
  
  def top
    @user = current_user
  end
  
end
