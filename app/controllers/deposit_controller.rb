# class deposit controller
class DepositController < ApplicationController
  def index
    @user = User.find_by_id(current_user.id)
    @account_cash = Account.where(user_id: current_user.id)
  end

  def create
    account_cash = Account.get_account_amount(current_user.id, deposit_params[:currency])
    account_cash.each do |a|
      @user_amount = a.amount
    end
    @user_amount += deposit_params[:deposit_sum].to_i
    account_cash.update(amount: @user_amount)
    redirect_to user_deposit_index_path
  end

  private

  def deposit_params
    params.require(:deposit).permit(:deposit_sum, :currency).merge(
      user_id: current_user.id
    )
  end
end
