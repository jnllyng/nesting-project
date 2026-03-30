require 'csv'

# Admin User
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

# Categories from CSV
CSV.foreach(Rails.root.join('db/data/categories.csv'), headers: true) do |row|
  Category.find_or_create_by(name: row['name']).update(description: row['description'])
end

# Products from CSV
CSV.foreach(Rails.root.join('db/data/products.csv'), headers: true) do |row|
  category = Category.find_by(name: row['category'])
  next unless category

  Product.find_or_create_by(name: row['name']).update(
    description: row['description'],
    price: row['price'],
    stock: row['stock'],
    category: category,
    image_url: row['image']
  )
end
