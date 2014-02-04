class UsersController < ApplicationController
  def edit
      @user = current_user
    end

    def update_password
      @user = User.find(current_user.id)
      if @user.update(user_params)
        # Sign in the user by passing validation in case his password changed
        sign_in @user, :bypass => true
        redirect_to root_path
      else
        respond_to do |format|
        format.json { render json: @user.errors.full_messages, status: :unprocessable_entity }
      end
      end
    end

    private

    def user_params
      params.required(:user).permit(:password, :password_confirmation)
    end
end