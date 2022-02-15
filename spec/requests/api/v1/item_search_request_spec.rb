require 'rails_helper'

describe 'Item Search API' do
  it 'lists all items based on search' do
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    item1 = create(:item, name: 'Bag of Dimes', merchant: merchant)
    item2 = create(:item, name: 'Shovel', merchant: merchant)
    item3 = create(:item, name: 'Keycaps', merchant: merchant)
    item4 = create(:item, name: 'Shovel Polisher', merchant: merchant)
    item5 = create(:item, name: 'dime sharpener', merchant: merchant2)

    get '/api/v1/items/find_all?name=dime'

    result = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200)
    expect(result[:data].count).to eq(2)
    expect(result[:data])
  end

  it 'has missing parameters' do
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    item1 = create(:item, name: 'Bag of Dimes', merchant: merchant)
    item2 = create(:item, name: 'Shovel', merchant: merchant)
    item3 = create(:item, name: 'Keycaps', merchant: merchant)
    item4 = create(:item, name: 'Shovel Polisher', merchant: merchant)
    item5 = create(:item, name: 'dime sharpener', merchant: merchant2)

    get '/api/v1/items/find_all'

    result = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(400)
    expect(result[:data]).to have_key(:message)
  end

  it 'has empty parameters' do
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    item1 = create(:item, name: 'Bag of Dimes', merchant: merchant)
    item2 = create(:item, name: 'Shovel', merchant: merchant)
    item3 = create(:item, name: 'Keycaps', merchant: merchant)
    item4 = create(:item, name: 'Shovel Polisher', merchant: merchant)
    item5 = create(:item, name: 'dime sharpener', merchant: merchant2)

    get '/api/v1/items/find_all?name='

    result = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(400)
    expect(result[:data]).to have_key(:message)
  end

  it 'has empty parameters' do
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    item1 = create(:item, name: 'Bag of Dimes', merchant: merchant)
    item2 = create(:item, name: 'Shovel', merchant: merchant)
    item3 = create(:item, name: 'Keycaps', merchant: merchant)
    item4 = create(:item, name: 'Shovel Polisher', merchant: merchant)
    item5 = create(:item, name: 'dime sharpener', merchant: merchant2)

    get '/api/v1/items/find_all?name=Mart'

    result = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(400)
    expect(result[:data]).to eq([])
  end

  it 'searches for a word successfully' do
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    item1 = create(:item, name: 'Bag of Dimes', merchant: merchant)
    item2 = create(:item, name: 'Shovel', merchant: merchant)
    item3 = create(:item, name: 'Keycaps', merchant: merchant)
    item4 = create(:item, name: 'Shovel Polisher', merchant: merchant)
    item5 = create(:item, name: 'dime sharpener', merchant: merchant2)

    get '/api/v1/items/find?name=Shovel'

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end

  it 'has missing parameters' do
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    item1 = create(:item, name: 'Bag of Dimes', merchant: merchant)
    item2 = create(:item, name: 'Shovel', merchant: merchant)
    item3 = create(:item, name: 'Keycaps', merchant: merchant)
    item4 = create(:item, name: 'Shovel Polisher', merchant: merchant)
    item5 = create(:item, name: 'dime sharpener', merchant: merchant2)

    get '/api/v1/items/find'
    result = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(result[:data][:message]).to eq('Search parameters cannot be missing')
    expect(result[:data][:message]).to be_a(String)
  end

  it 'has empty parameters' do
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    item1 = create(:item, name: 'Bag of Dimes', merchant: merchant)
    item2 = create(:item, name: 'Shovel', merchant: merchant)
    item3 = create(:item, name: 'Keycaps', merchant: merchant)
    item4 = create(:item, name: 'Shovel Polisher', merchant: merchant)
    item5 = create(:item, name: 'dime sharpener', merchant: merchant2)

    get '/api/v1/items/find?name='
    result = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(result[:data][:message]).to_not eq(merchant.name)
    expect(result[:data][:message]).to eq('Search cannot be empty')
  end

  it 'yields 0 results' do 
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    item1 = create(:item, name: 'Bag of Dimes', merchant: merchant)
    item2 = create(:item, name: 'Shovel', merchant: merchant)
    item3 = create(:item, name: 'Keycaps', merchant: merchant)
    item4 = create(:item, name: 'Shovel Polisher', merchant: merchant)
    item5 = create(:item, name: 'dime sharpener', merchant: merchant2)

    get '/api/v1/items/find?name=Mart'

    result = JSON.parse(response.body, symbolize_names: true)
 
    expect(response).to_not be_successful 
    expect(response.status).to eq(400)
    expect(result[:data]).to have_key(:message)
  end

  it 'finds the minimum price of 50' do 
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    item1 = create(:item, name: 'Bag of Dimes', unit_price: 53, merchant: merchant)
    item2 = create(:item, name: 'Shovel', unit_price: 23, merchant: merchant)
    item3 = create(:item, name: 'Keycaps', unit_price: 7, merchant: merchant)
    item4 = create(:item, name: 'Shovel Polisher', unit_price: 100, merchant: merchant)
    item5 = create(:item, name: 'dime sharpener', unit_price: 999, merchant: merchant2)

    get '/api/v1/items/find?min_price=50'

    result = JSON.parse(response.body, symbolize_names: true)
    # binding.pry
    expect(response).to be_successful
    expect(result[:data].size).to eq(3)
    expect(result[:data][0][:attributes][:name]).to eq('Bag of Dimes')
    expect(result[:data][1][:attributes][:name]).to eq('Shovel Polisher')
    expect(result[:data][2][:attributes][:name]).to eq('dime sharpener')
  end

  it 'finds the minimum price of 50' do 
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    item1 = create(:item, name: 'Bag of Dimes', unit_price: 53, merchant: merchant)
    item2 = create(:item, name: 'Shovel', unit_price: 23, merchant: merchant)
    item3 = create(:item, name: 'Keycaps', unit_price: 7, merchant: merchant)
    item4 = create(:item, name: 'Shovel Polisher', unit_price: 100, merchant: merchant)
    item5 = create(:item, name: 'dime sharpener', unit_price: 999, merchant: merchant2)

    get '/api/v1/items/find?max_price=23'

    result = JSON.parse(response.body, symbolize_names: true)
    # binding.pry
    expect(response).to be_successful
    expect(result[:data].size).to eq(2)
    expect(result[:data][0][:attributes][:name]).to eq('Shovel')
    expect(result[:data][1][:attributes][:name]).to eq('Keycaps')
  end

  it 'finds the minimum and maximum price' do 
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    item1 = create(:item, name: 'Bag of Dimes', unit_price: 53, merchant: merchant)
    item2 = create(:item, name: 'Shovel', unit_price: 23, merchant: merchant)
    item3 = create(:item, name: 'Keycaps', unit_price: 7, merchant: merchant)
    item4 = create(:item, name: 'Shovel Polisher', unit_price: 100, merchant: merchant)
    item5 = create(:item, name: 'dime sharpener', unit_price: 999, merchant: merchant2)

    get '/api/v1/items/find?max_price=100&min_price=50'

    result = JSON.parse(response.body, symbolize_names: true)
   binding.pry
    expect(response).to be_successful
    expect(result[:data].size).to eq(2)
    expect(result[:data][0][:attributes][:name]).to eq('Shovel')
    expect(result[:data][1][:attributes][:name]).to eq('Keycaps')
  end

end
