class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit]

  def index
    @admins = User.admins
    @teachers = User.teachers
    @students = User.students
    respond_to do |format|
      format.html
      format.csv { send_data @students.to_csv }
    end
  end

  def show
  end

  def create
    @user = User.new(users_params)
    if @user.save
      redirect_to users_path, notice: "User succesfully created!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    respond_to do |format|
      if @user.update(users_params)
        bypass_sign_in(@user) unless @user != current_user
        format.html { redirect_to root_path, notice: 'User succesfully updated!' }
        format.json { render :show, status: :ok, location: root_path }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def users_params
    params.require(:user).permit(:first_name, :last_name, :school_class_id, :subject_id, :email, :password, :password_confirmation)
  end


end
