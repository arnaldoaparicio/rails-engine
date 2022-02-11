require 'rails_helper'

describe 'Merchant Search API' do
  it 'searches for a word successfully' do
    merchant = create(:merchant, name: 'Mart')
    get '/api/v1/merchants/find?name=Mart'

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end

  it 'has missing parameters' do
    merchant = create(:merchant)

    get '/api/v1/merchants/find'
    result = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(result[:data][:message]).to eq('Search parameters cannot be missing')
    expect(result[:data][:message]).to be_a(String)
  end

  it 'has empty parameters' do
    merchant = create(:merchant)

    get '/api/v1/merchants/find?name='
    result = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(result[:data][:message]).to_not eq(merchant.name)
    expect(result[:data][:message]).to eq('Search cannot be empty')
  end

  it 'yields 0 results' do 
    merchant = create(:merchant, name: 'Joe Schmoe')

    get '/api/v1/merchants/find?name=Mart'

    result = JSON.parse(response.body, symbolize_names: true)
 
    expect(response).to_not be_successful 
    expect(response.status).to eq(400)
    expect(result[:data]).to have_key(:message)
  end
end
