class User::RegistersController < ApplicationController
  
  def index
    @registers = Register.where.not(is_deleted: "true")
  end
  
end
