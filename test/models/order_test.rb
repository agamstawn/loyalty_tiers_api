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
require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
