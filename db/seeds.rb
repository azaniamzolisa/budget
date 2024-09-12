# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
require 'faker'

# Clear existing data
puts "Clearing existing data..."
User.destroy_all
Budget.destroy_all
ExpenseCategory.destroy_all
Expense.destroy_all
Notification.destroy_all
Report.destroy_all

# Create Users
puts "Seeding Users..."
5.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password'
  )
end

User.create!(
  email: "prince@example.com",
  password: 'password'
)

# Create Expense Categories
puts "Seeding Expense Categories..."
categories = ['Rent', 'Groceries', 'Transportation', 'Entertainment', 'Healthcare', 'Utilities', 'Dining Out', 'Miscellaneous', 'Investments']
categories.each do |category|
  ExpenseCategory.create!(name: category)
end

# Create Budgets for Users
puts "Seeding Budgets..."
users = User.all
users.each do |user|
  rand(1..15).times do
    budget = Budget.create!(
      user: user,
      name: Faker::App.name,
      budget_type: ['Monthly', 'Yearly', 'Weekly'].sample,
      total_amount: Faker::Number.between(from: 500, to: 5000),
      due_date: Faker::Date.forward(days: 30)
    )

    # Create Expenses for each Budget
    puts "Seeding Expenses for Budget: #{budget.name}"
    expense_categories = ExpenseCategory.all
    rand(3..19).times do
      Expense.create!(
        budget: budget,
        name: Faker::Commerce.product_name,
        amount: Faker::Commerce.price(range: 10.0..500.0),
        category_id: expense_categories.sample.id,
        recurrence: ['One-time', 'Weekly', 'Monthly'].sample
      )
    end
  end
end

# Create Notifications for Users
puts "Seeding Notifications..."
users.each do |user|
  rand(2..5).times do
    Notification.create!(
      user: user,
      message: Faker::Lorem.sentence(word_count: 8),
      notification_date: Faker::Date.backward(days: 15),
      is_read: [true, false].sample
    )
  end
end

# Create Reports for Users
puts "Seeding Reports..."
users.each do |user|
  rand(1..3).times do
    Report.create!(
      user: user,
      report_type: ['Monthly Summary', 'Expense Report', 'Budget Overview'].sample,
      content: Faker::Lorem.paragraph(sentence_count: 10)
    )
  end
end

puts "Seeding completed!"
