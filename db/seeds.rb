User.first_or_create(email: 'ekingan@mathllc.com', subdomain: 'home')
User.first_or_create(email: 'ekingan@gmail.com', subdomain: 'away')
User.first_or_create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?