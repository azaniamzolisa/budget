class ExpensesController < ApplicationController
  before_action :set_budget
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  def index
    @expenses = @budget.expenses
  end

  def show

  end

  def new
    @expense = @budget.expenses.new
  end

  def create
    @expense = @budget.expenses.new(expense_params)

    if @expense.save
      redirect_to budget_path(@budget), notice: 'Expense created successfully'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @expense.update(expense_params)
      redirect_to budget_path(@budget), notice: 'Expense updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @expense.destroy
    redirect_to budget_path(@budget), notice: 'Expense deleted successfully'
  end

  private

  def set_budget
    @budget = current_user.budgets.find(params[:budget_id])
  end

  def set_expense
    @expense = @budget.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, :category_id, :recurrence, :due_date)
  end
end
