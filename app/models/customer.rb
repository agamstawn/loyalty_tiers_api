# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  name       :string
#  tier       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Customer < ApplicationRecord
  has_many :orders

  before_save :set_init_tier
  
  def update_tier
    total_spent = orders.sum(:totalInCents)

    if total_spent < 100
      new_tier = "Bronze"
    elsif total_spent > 99 && total_spent < 500
      new_tier = "Silver"
    elsif total_spent > 499
      new_tier = "Gold"
    end

    update(tier: "Tier #{new_tier}")
  end

  def set_init_tier
    self.tier = "Bronze" if self.tier.blank?
  end
end
