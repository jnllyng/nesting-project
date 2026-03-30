# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
AdminUser.find_or_create_by!(email: 'admin@example.com') do |admin|
  admin.password = 'password'
  admin.password_confirmation = 'password'
end

# Provinces
provinces = [
  { name: "Alberta", gst: 0.05, pst: 0.00, hst: 0.00 },
  { name: "British Columbia", gst: 0.05, pst: 0.07, hst: 0.00 },
  { name: "Manitoba", gst: 0.05, pst: 0.07, hst: 0.00 },
  { name: "New Brunswick", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Newfoundland and Labrador", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Northwest Territories", gst: 0.05, pst: 0.00, hst: 0.00 },
  { name: "Nova Scotia", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Nunavut", gst: 0.05, pst: 0.00, hst: 0.00 },
  { name: "Ontario", gst: 0.00, pst: 0.00, hst: 0.13 },
  { name: "Prince Edward Island", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Quebec", gst: 0.05, pst: 0.09975, hst: 0.00 },
  { name: "Saskatchewan", gst: 0.05, pst: 0.06, hst: 0.00 },
  { name: "Yukon", gst: 0.05, pst: 0.00, hst: 0.00 }
]

provinces.each do |province|
  Province.find_or_create_by(name: province[:name]).update(province)
end
