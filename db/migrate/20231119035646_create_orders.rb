class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :orderId, unique: true
      t.integer :totalInCents
      t.datetime :date

      t.timestamps
    end
  end
end
