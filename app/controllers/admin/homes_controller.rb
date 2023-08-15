class Admin::HomesController < ApplicationController
  
before_action :authenticate_admin!, except: [:top]
  
  def top
  end
  
end
