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
    total_spent = orders_last_year.sum(:totalInCents)

    if total_spent < 100
      new_tier = "Bronze"
    elsif total_spent > 99 && total_spent < 500
      new_tier = "Silver"
    elsif total_spent > 499
      new_tier = "Gold"
    end

    update(tier: new_tier)
  end

  def set_init_tier
    self.tier = "Bronze" if self.tier.blank? 
  end

  def current_tier_info
    current_tier = tier
    start_date = Date.today.beginning_of_year.prev_year
    amount_spent_since_start_date = calculate_amount_spent_since(start_date)
    next_tier_amount = calculate_next_tier_amount
    downgrade_date = Date.today.end_of_year
    downgrade_next_year = calculate_downgrade_next_year
    keep_current_tier_amount = calculate_keep_current_tier_amount

    {
      current_tier: current_tier,
      start_date: start_date,
      amount_spent_since_start_date: amount_spent_since_start_date,
      next_tier_amount: next_tier_amount,
      downgrade_date: downgrade_date,
      # amount_this_year: calculate_amount_spent_this_year,
      downgrade_next_year: downgrade_next_year,
      keep_current_tier_amount: keep_current_tier_amount
    }
  end

  def orders_last_year
    start_date = Date.today.beginning_of_year.prev_year
    orders.where('date >= ?', start_date).select(:id, :date, :totalInCents)
  end

  private

  def calculate_amount_spent_since(start_date)
    orders.where('date >= ?', start_date).sum(:totalInCents)
  end

  def calculate_amount_spent_this_year
    orders.where(date: Date.today.beginning_of_year..Date.today.end_of_year).sum(:totalInCents)
  end

  def calculate_next_tier_amount
    case 
    when tier.eql?("Bronze")
      next_tier_amount = 100 - calculate_amount_spent_this_year
    when tier.eql?("Silver")
      next_tier_amount = 500 - calculate_amount_spent_this_year
    when tier.eql?("Gold")
      next_tier_amount = 0
    end
    
    next_tier_amount
  end
  
  def calculate_downgrade_next_year
    case 
    when tier.eql?("Bronze") || tier.eql?("Silver")
      downgrade_tier = "Bronze"
    when tier.eql?("Gold")
      downgrade_tier = "Silver"
    end

    downgrade_tier
  end

  def calculate_keep_current_tier_amount
    case 
    when tier.eql?("Bronze")
      keep_amount = 0  
    when tier.eql?("Silver")
      keep_amount = 100 - calculate_amount_spent_this_year
    when tier.eql?("Gold")
      keep_amount = 500 - calculate_amount_spent_this_year
    end

    keep_amount = 0 if keep_amount <= 0
    keep_amount 
  end
end
