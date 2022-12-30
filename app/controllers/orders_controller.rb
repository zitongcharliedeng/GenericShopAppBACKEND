class OrdersController < ApplicationController
  def index
    if (request.headers["sessionToken"])
      @session = Session.find_by(token: request.headers["sessionToken"])
      @user = User.find_by(id: @session.user_id)
      @orders = Order.all
      @ordersFromUser = @orders.where { |order| order.user_id == @user.id }
      render json: {ordersFromUser: @ordersFromUser}
    else 
      throw "sessionToken does not exist"
    end
  end

  def create
    if (request.headers["sessionToken"])
      @session = Session.find_by(token: request.headers["sessionToken"])
      @user = User.find_by(id: @session.user_id)
      @order = Order.new(user_id: @user.id, list: params[:order][:list])
      if @order.save
        render json: {alert: "success", message: "order placed", orderNumber: @order.id}
      else
        render json: {alert: "error", message: "order not placed"}
      end
    else  
      throw "sessionToken does not exist"
    end
  end
end
