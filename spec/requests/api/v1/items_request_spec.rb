require 'rails_helper'

describe 'Item API' do
  it 'sends a list of items' do
    merchant = create(:merchant)
    create_list(:item, 3, merchant: merchant)


    get '/api/v1/items'

    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(3)
    expect(items[:data][0]).to have_key(:id)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes]).to have_key(:merchant_id)
      
    end
  end
  
    
    it 'can get one item by its id' do 
      merchant = create(:merchant)
      id = create(:item, merchant: merchant).id

      get "/api/v1/items/#{id}"

      item = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
    end
end
