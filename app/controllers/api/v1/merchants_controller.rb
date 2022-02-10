class Api::V1::MerchantsController < ApplicationController
  def index
    if params.has_key?(:item_id)
      item = Item.find(params[:item_id])
      json_response(MerchantSerializer.new(item.merchant))
    else
      render json: MerchantSerializer.new(Merchant.all)
    end
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end




  private

  def merchant_params
    params.permit(:name)
  end
end
