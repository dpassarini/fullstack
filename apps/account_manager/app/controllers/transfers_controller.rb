class TransfersController < ApplicationController
  before_action :doorkeeper_authorize!

  def charge_account
    ts = TransferService.new
    result = ts.charge_account(
      receiver_account_id: transfer_params[:receiver_account_id],
      value_cents: transfer_params[:value_cents]
    )
    if result
      render json: { transfer_identifier: result }, status: 201
    else
      render json: {}, status: 412
    end
  end

  def cash_back
    ts = TransferService.new
    result = ts.cash_back(transfer_params[:charge_identifier])
    if result
      render json: {identifier: result}, status: 201
    else
      render json: { error: "transfer not found" }, status: 404
    end
  end

  def transfer
    ts = TransferService.new
    if transfer_params[:receiver_account_id].present? &&
       transfer_params[:sender_account_id].present? &&
       transfer_params[:value_cents].present?
      transfer = ts.transfer_value(
        receiver_account_id: transfer_params[:receiver_account_id],
        sender_account_id: transfer_params[:sender_account_id],
        value_cents: transfer_params[:value_cents]
      )
      if transfer[:transfer]
        render json: { identifier: transfer[:message] }, status: 201
      else
        render json: { error: transfer[:message] }, status: 412
      end
    else
      render json: { error: 'insuficient params' }, status: 400
    end
  end

  private

  def transfer_params
    params
      .require(:transfer)
      .permit(:value_cents, :sender_account_id, :receiver_account_id, :charge_identifier)
  end
end
