class Api::V1::ItemSearchController < ApplicationController
  def index
    results = Item.all_items_search(params[:name])
    if params[:name].nil?
      render json: { data: { message: 'Search parameters cannot be missing' } }, status: 400
    elsif results.empty?
      render json: ItemSerializer.new(results), status: 400
    elsif params[:name] == ''
      render json: { data: { message: 'Search cannot be empty' } }, status: 400
    else
      json_response(ItemSerializer.new(results))
    end
  end

  def show

    results = Item.item_search(params[:name])
    if params.has_key?(:name) && params[:name].nil?
      render json: { data: { message: 'Search parameters cannot be missing' } }, status: 400
    elsif params[:name] == ''
      render json: { data: { message: 'Search cannot be empty' } }, status: 400
    elsif params.has_key?(:min_price)
      min = Item.minimum_price(params[:min_price])
      json_response(ItemSerializer.new(min))
    elsif params.has_key?(:max_price)
      max = Item.maximum_price(params[:max_price])
      json_response(ItemSerializer.new(max))
    elsif params.has_key?(:max_price) && params.has_key?(:min_price)
      min_and_max = Item.min_and_max_price(params[:max_price], params[:min_price])
      json_response(ItemSerializer.new(min_and_max))
    elsif params.empty?
      render json: { data: { message: 'No results found' } }, status: 400
    else
      json_response(ItemSerializer.new(results.first))
    end
  end
end
