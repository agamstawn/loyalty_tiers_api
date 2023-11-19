# == Schema Information
#
# Table name: orders
#
#  id           :bigint           not null, primary key
#  orderId      :string
#  totalInCents :integer
#  date         :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  customer_id  :bigint
#
class Order < ApplicationRecord

  attr_accessor :customerId, :customerName

  validates :orderId, presence: true, uniqueness: true
  
  belongs_to :customer

end
