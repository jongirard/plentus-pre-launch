class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
def create
    @user = User.new(secure_params)
    if @user.valid?
    @user.signup
    flash[:notice] = "Thank you. You have successfully signed up."
    redirect_to register_path
  else
    render :new
  end
end


private

  def secure_params
  params.require(:user).permit(:fullname, :email, :password, :country_id, :state_id)
  end
  
end