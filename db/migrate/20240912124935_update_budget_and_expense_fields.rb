class UpdateBudgetAndExpenseFields < ActiveRecord::Migration[7.1]
  def change
    remove_column :budgets, :start_date, :date
    remove_column :budgets, :end_date, :date
    add_column :budgets, :due_date, :date
  end
end
