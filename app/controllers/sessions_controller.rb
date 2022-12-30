class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      @session = Session.find_by(user_id: @user.id)
      @session.regenerate_token
      render json: {alert: "success", token: @session.token, message: "Login Successful"}
    else
      render json: {alert: "error", message: "Login Unsuccessful"}
    end
  end
end
