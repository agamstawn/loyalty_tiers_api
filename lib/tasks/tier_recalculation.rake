namespace :tier_recalculation do
  desc 'Recalculate customer tiers at the end of each year'

  task :recalculate => :environment do
    Customer.all.each do |customer|
      customer.update_tier
    end

    puts 'Customer tiers recalculated successfully.'
  end
end
