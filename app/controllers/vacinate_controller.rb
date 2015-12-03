class VacinateController < ApplicationController
  def index
  	@users = User.search(params[:search]).order("created_at DESC")
  end

  def search
  	@user = User.search(params[:search])
  end
end
