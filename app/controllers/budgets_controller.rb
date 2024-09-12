class BudgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_budget, only: [:show, :edit, :update, :destroy]

  def index
    @budgets = current_user.budgets
  end

  def show
    @budget = Budget.find(params[:id])
    @total = @budget.expenses.sum(:amount)
  end

  def new
    @budget = Budget.new
  end

  def create
    @budget = Budget.new(budget_params)
    @budget.user = current_user
    if @budget.save
      redirect_to @budget, notice: 'Budget created successfully'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @budget.update(budget_params)
      redirect_to @budget, notice: 'Budget updated successfully'
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def set_budget
    @budget = current_user.budgets.find(params[:id])
  end

  def budget_params
    params.require(:budget).permit(:name, :budget_type, :total_amount, :due_date_date)
  end
end
