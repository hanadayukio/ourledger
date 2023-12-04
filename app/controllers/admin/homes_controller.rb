class Admin::HomesController < ApplicationController
  
  # topページでは認証をスキップ
before_action :authenticate_admin!, except: [:top]
  
  def top
    @admin = current_admin
  end
  
end
