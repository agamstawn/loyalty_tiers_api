class AddCustomerReferenceToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :customer, index: true
  end
end
