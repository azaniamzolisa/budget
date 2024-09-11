class CreateBudgets < ActiveRecord::Migration[7.1]
  def change
    create_table :budgets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :budget_type
      t.decimal :total_amount
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
