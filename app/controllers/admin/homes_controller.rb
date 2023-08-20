class Admin::HomesController < ApplicationController
  
before_action :authenticate_admin!, except: [:top]
  
  def top
    @admin = current_admin
  end
  
end
