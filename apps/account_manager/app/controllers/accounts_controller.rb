class AccountsController < ApplicationController
  before_action :doorkeeper_authorize!

  def create
    account = Account.new(account_params)
    account.users = [current_user]
    account.status = 'active'
    if account.save
      render json: account, status: 200
    else
      render json: account.errors, status: 412
    end
  end

  def show
    begin
      account = Account.find(params[:id])
      render json: account, status: 200
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: 404
    end
  end

  def index
    render json: current_user.accounts, status: 200
  end

  private
  def account_params
    params.require(:account).permit(:name, :status, :parent_account_id)
  end
end
