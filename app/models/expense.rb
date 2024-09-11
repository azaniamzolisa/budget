class Expense < ApplicationRecord
  belongs_to :budget
  belongs_to :category, class_name: 'ExpenseCategory', foreign_key: 'category_id'
end
