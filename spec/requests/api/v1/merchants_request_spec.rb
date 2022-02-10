require 'rails_helper'

describe 'Merchant API' do
  xit 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)
    expect(merchants[:data][0]).to have_key(:id)
    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  xit 'can get one merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to eq(id.to_s)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  xit 'can get all of the merchants items' do
    merchant = create(:merchant)
    create_list(:item, 3, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items/"

    expect(response).to be_successful
    expect(merchant.items.count).to eq(3)
  end

  xit 'can get an items merchant' do
    merchant = create(:merchant)
    item = create_list(:item, 2, merchant: merchant)
    last_item = Item.all.last

    get "/api/v1/items/#{last_item.id}/merchant"

    expect(response).to be_successful
    expect(last_item.merchant).to eq(merchant)
  end

  
end
