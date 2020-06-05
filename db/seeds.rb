# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

this_year_sale_values = [1000, 2000, 3000, 2500, 2700, 2500, 3000]
this_year_sale_values.each_with_index do |sale_value, index|
  Sale.create(date: Time.current.beginning_of_year + index.month, sale_value: sale_value)
end

last_year_sale_values = [700, 1700, 2700, 2000, 1800, 1500, 2000]
last_year_sale_values.each_with_index do |sale_value, index|
  Sale.create(date: Time.current.years_ago(1).beginning_of_year + index.month, sale_value: sale_value)
end

