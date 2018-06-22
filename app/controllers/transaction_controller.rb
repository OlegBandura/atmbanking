# class transaction controller
class TransactionController < ApplicationController
  def index
    @user = User.find_by_id(current_user.id)
    @account_cash = Account.where(user_id: current_user.id)
  end

  def create
    account_cash = Account.get_account_amount(
      current_user.id,
      transaction_params[:currency]
    )
    transaction_user = Account.get_account_amount(
      transaction_params[:transaction_user_id],
      transaction_params[:currency]
    )
    update_user(account_cash)
    update_transaction_user(transaction_user)
  end

  private

  def update_user(account_cash)
    account_cash.each do |a|
      @user_amount = a.amount
    end
    @user_amount -= transaction_params[:transaction_sum].to_i
    account_cash.update(amount: @user_amount)
  end

  def update_transaction_user(transaction_user)
    transaction_user.each do |a|
      @user_amount = a.amount
    end
    @user_amount += transaction_params[:transaction_sum].to_i
    transaction_user.update(amount: @user_amount)
    redirect_to user_transaction_index_path
  end

  def transaction_params
    params.require(:transaction).permit(
      :transaction_sum, :currency, :transaction_user_id
    ).merge(user_id: current_user.id)
  end
end
