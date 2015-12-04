class VacinateController < ApplicationController
  before_action :set_user, only: [:user]

  def index
  	@users = User.search(params[:search]).order("created_at DESC")
  end

  def search
  end

   def edit
   	
  end

  def user
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

end
