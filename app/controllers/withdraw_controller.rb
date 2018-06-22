# Class Witndraw controller
class WithdrawController < ApplicationController
  def index
    @user = User.find_by_id(current_user.id)
    @account_cash = Account.where(user_id: current_user.id)
  end

  def create
    account_cash = Account.get_account_amount(
      current_user.id, withdraw_params[:currency]
    )
    account_cash.each do |a|
      @user_amount = a.amount
    end
    @user_amount -= withdraw_params[:withdraw_sum].to_i
    account_cash.update(amount: @user_amount)
    redirect_to user_withdraw_index_path
  end

  private

  def withdraw_params
    params.require(:withdraw).permit(:withdraw_sum, :currency).merge(
      user_id: current_user.id
    )
  end
end
