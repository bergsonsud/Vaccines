class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @users = @users.search(params[:search]).order("created_at DESC") if params[:search].present?      
  end

  # GET /users/1
  # GET /users/1.json
  def show

    #@vaccines = ''
    @vaccines = @user.vaccines.pluck(:id)
    @category = User.age_category(@user).id
    @t_category = Vaccine.where('category_id = (?)', @category).count
    @t_user = @user.vaccines.count
    @total = @t_category - @t_user #Vaccine.where('id not in (?)', @vaccines).count  
    @percent = (@t_user.to_f/@t_category.to_f)*100

    if @user.vaccines.count>0
      @vaccines = @user.vaccines.pluck(:id)
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def vacinate
    @user = User.find(params[:id])     
    @vaccine = Vaccine.find(params[:vaccine][:id])
    @user.vaccines << @vaccine
    #render "users/show"
    redirect_to user_path(@user)
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :cpf,:birth)
    end
end
