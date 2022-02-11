class Api::V1::MerchantSearchController < ApplicationController
  def index
    results = Merchant.all_merchants_search(params[:name])
    if params[:name].nil?
      render json: { data: { message: 'Search parameters cannot be missing' } }, status: 400
    elsif results.empty?
      render json: MerchantSerializer.new(results), status: 400
    elsif params[:name] == ''
      render json: { data: { message: 'Search cannot be empty' } }, status: 400
    else
      json_response(MerchantSerializer.new(results))
    end
  end
  
  def show
    results = Merchant.merchant_search(params[:name])
    if params[:name].nil?
      render json: { data: { message: 'Search parameters cannot be missing' } }, status: 400
    elsif results.empty?
      render json: { data: { message: 'No results found' } }, status: 400
    elsif params[:name] == ''
      render json: { data: { message: 'Search cannot be empty' } }, status: 400
    else
      json_response(MerchantSerializer.new(results.first))
    end
  end
end
