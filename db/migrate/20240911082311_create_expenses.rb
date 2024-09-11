class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.references :budget, null: false, foreign_key: true
      t.string :name
      t.decimal :amount
      t.integer :category_id
      t.string :recurrence
      t.date :due_date

      t.timestamps
    end
  end
end
