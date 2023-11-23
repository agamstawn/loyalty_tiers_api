# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

customers = []
5.times do |i|
  customers << Customer.create!(
    name: "Customer #{i + 1}"
  )
end

# Create orders
customers.each do |customer|
  3.times do |i|
    Order.create!(
      customer: customer,
      orderId: "T#{customer.id}#{i + 1}",
      totalInCents: rand(0..200),
      date: Time.now - rand(1..765).days,
      status: ["pending", "completed"].sample
    )
  end
end