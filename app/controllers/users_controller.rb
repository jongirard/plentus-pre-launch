class UsersController < ApplicationController
  layout "nav_disabled"
  
  def new
    @user = User.new
  end
  
def create
    @user = User.new(secure_params)
    if @user.valid?
    @user.signup
    flash[:notice] = "Thank you. You will be notified of our launch at #{@user.email}."
    redirect_to registration_path
  else
    render :new
  end
end


private

  def secure_params
  params.require(:user).permit(:fullname, :email)
  end
  
end