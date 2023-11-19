class Api::V1::OrdersController < ApplicationController
  before_action :find_customer, only: [:create]

  def create
    @order = Order.new(order_params)
    @order.customer_id = @customer.id 
    
    if @order.save
      @customer.update_tier
      render json: @order, status: :created
    else
      render json: @order.errors.messages, status: :unprocessable_entity
    end

  end
  
  private
  
  def order_params
    params.require(:order).permit(:orderId, :totalInCents, :date)
  end
  
  def find_customer
    @customer = Customer.find_by(id: params[:customerId])
  end
end
