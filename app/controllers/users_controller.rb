class UsersController < ApplicationController
  def create
    @email = params[:user][:email]
    @password = params[:user][:password]
    @user = User.new({email: @email, password: @password})
    if @user.save
      Session.new(user_id: @user.id).save
      render json: {alert: "success", message: "User created successfully"}
    else
      render json: {alert: "error", message: "Failed to create user due to incorrect/ already-in-use email"}
    end
  end
  private
    def user_params
      return params.require(:user).permit(:email, :password)
    end
end
