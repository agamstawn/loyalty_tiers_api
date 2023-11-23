class Api::V1::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])

    render json: @customer.current_tier_info

  end

  def orders_since_last_year
    @customer = Customer.find(params[:id])
    @orders = @customer.orders_since_last_year

    render json: @orders

  end

end
