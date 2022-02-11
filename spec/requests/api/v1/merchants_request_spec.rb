require 'rails_helper'

describe 'Merchant API' do
  it 'sends a list of merchants' do
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

  it 'can get one merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to eq(id.to_s)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it 'can get all of the merchants items' do
    merchant = create(:merchant)
    create_list(:item, 3, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items/"

    expect(response).to be_successful
    expect(merchant.items.count).to eq(3)
  end

  it 'can get an items merchant' do
    merchant = create(:merchant)
    item = create_list(:item, 2, merchant: merchant)
    last_item = Item.all.last

    get "/api/v1/items/#{last_item.id}/merchant"

    expect(response).to be_successful
    expect(last_item.merchant).to eq(merchant)
  end


  








    it 'lists all merchants based on search' do
   
    merchant1 = create(:merchant, name: 'Bag of Dimes')
    merchant2 = create(:merchant, name: 'Shovel')
    merchant3 = create(:merchant, name: 'Keycaps')
    merchant4 = create(:merchant, name: 'Shovel Polisher')
    merchant5 = create(:merchant, name: 'dime sharpener')

    get '/api/v1/merchants/find_all?name=dime'

    result = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200)
    expect(result[:data].count).to eq(2)
    expect(result[:data])
  end

  it 'has missing parameters' do
    merchant1 = create(:merchant, name: 'Bag of Dimes')
    merchant2 = create(:merchant, name: 'Shovel')
    merchant3 = create(:merchant, name: 'Keycaps')
    merchant4 = create(:merchant, name: 'Shovel Polisher')
    merchant5 = create(:merchant, name: 'dime sharpener')

    get '/api/v1/merchants/find_all'

    result = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(400)
    expect(result[:data]).to have_key(:message)
  end

  it 'has empty parameters' do
    merchant1 = create(:merchant, name: 'Bag of Dimes')
    merchant2 = create(:merchant, name: 'Shovel')
    merchant3 = create(:merchant, name: 'Keycaps')
    merchant4 = create(:merchant, name: 'Shovel Polisher')
    merchant5 = create(:merchant, name: 'dime sharpener')

    get '/api/v1/merchants/find_all?name='

    result = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(400)
    expect(result[:data]).to have_key(:message)
  end

  it 'yields 0 results' do
    merchant1 = create(:merchant, name: 'Bag of Dimes')
    merchant2 = create(:merchant, name: 'Shovel')
    merchant3 = create(:merchant, name: 'Keycaps')
    merchant4 = create(:merchant, name: 'Shovel Polisher')
    merchant5 = create(:merchant, name: 'dime sharpener')

    get '/api/v1/merchants/find_all?name=Mart'

    result = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(400)
    expect(result[:data]).to eq([])
  end
  
end
