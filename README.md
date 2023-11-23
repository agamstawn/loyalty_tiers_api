# Loyalty Tier API

Loyalty Tier API is a Ruby on Rails application that manages customer information, orders, and loyalty tier calculations.

## Installation

### Prerequisites

Before you begin, ensure you have the following installed on your machine:

- [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
- [Rails](https://guides.rubyonrails.org/getting_started.html#installing-rails)
- [PostgreSQL](https://www.postgresql.org/download/)

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/loyalty_tier_api.git

  cd loyalty_tier_api

  bundle install

  set the .env file
  DATABASE_HOST="localhost" 
  DATABASE_USERNAME="<USERNAME>" // Replace with the actual username
  DATABASE_PASSWORD="<YOUR PASSWORD>"// Replace with the actual password
  DATABASE_NAME="<YOUR DATABASE NAME>"// Replace with the actual database name


  rails db:create db:migrate

  rails db:seed

  rake 'tier_recalculation:recalculate' // update tier last year 

  rails server


  The Loyalty Tier API should now be running at http://localhost:3000.
API Endpoints
1. Endpoint to create order

    URL: http://localhost:3000/api/v1/orders/create
    Method: POST
    Body:

    {
      "customerId": "5", // Replace with the actual customer id
      "customerName": "Customer 1",
      "orderId": "T12",
      "totalInCents": 34,
      "date": "2022-03-04T05:29:59.850Z"
    }

2. Endpoint to retrieve customer information by ID
    URL: http://localhost:3000/api/v1/customers/:id
    Method: GET

3. Endpoint to retrieve a customer's order history by ID

    URL: http://localhost:3000/api/v1/customers/:id/orders_last_year
    Method: GET

4. Endpoint to approve order to completed

    URL: http://localhost:3000/api/v1/orders/:id/approve  // Replace with the actual order id not orderId
    Method: POST