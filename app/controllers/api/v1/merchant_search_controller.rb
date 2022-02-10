class Api::V1::MerchantSearchController < ApplicationController

  def show
    results = Merchant.merchant_search(params[:name])
    if params[:name].nil?
      render json: {data: {message: 'Search parameters cannot be missing'}}
    elsif results.empty?
      render json: { data: { message: 'No results found' } }
    elsif params[:name] == ''
      render json: {data: {message: 'Search cannot be empty'}}
    else
      json_response(MerchantSerializer.new(results.first))
    end
  end
end
