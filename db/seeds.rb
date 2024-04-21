# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# AdminUser.create!(email: 'zach.jordan505@gmail.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

#  10.times do
#    Product.create!(
#      name: Faker::Commerce.product_name,
#      description: Faker::Lorem.paragraph(sentence_count: 3),
#      price: Faker::Commerce.price(range: 10.0..100.0)
#    )
# end

# Category.create(name: 'Camping')
# Category.create(name: 'Hiking')
# Category.create(name: 'Fishing')
# Category.create(name: 'Skiing')


# # Define your categories with corresponding placeholder images
# category_images = {
#   'Camping' => 'camping_placeholder.jpg',
#   'Hiking' => 'hiking_placeholder.jpg',
#   'Fishing' => 'fishing_placeholder.jpg',
#   'Skiing' => 'skiing_placeholder.jpg'
# }

# # Seed products
# 100.times do |i|
#   # Randomly select a category
#   category_name = ['Camping', 'Hiking', 'Fishing', 'Skiing'].sample

#   # Find or create the category
#   category_record = Category.find_or_create_by!(name: category_name)

#   # Generate a unique product name
#   product_name = Faker::Commerce.product_name

#   # Create a product associated with the category
#   product = Product.create!(
#     name: product_name,
#     description: Faker::Lorem.paragraph(sentence_count: 3),
#     price: Faker::Commerce.price(range: 10.0..100.0)
#   )

#   # Attach a placeholder image based on the category
#   placeholder_image = category_images[category_name]
#   product.image.attach(io: File.open("app/assets/images/placeholders/#{placeholder_image}"), filename: placeholder_image)

#   # Associate the product with the category
#   category_record.products << product
# end