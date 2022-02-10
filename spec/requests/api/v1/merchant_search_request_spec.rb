require 'rails_helper'

describe 'Merchant Search API' do
  it 'searches for a word successfully' do
    merchant = create(:merchant, name: 'Mart')
    get '/api/v1/merchants/find?name=Mart'
    # binding.pry
    expect(response).to be_successful
    expect(response.status).to eq(200)
  end

  it 'has missing parameters' do
    merchant = create(:merchant)

    get '/api/v1/merchants/find'
    result = JSON.parse(response.body, symbolize_names: true)
    # binding.pry
    expect(result[:data][:message]).to eq('Search parameters cannot be missing')
    expect(result[:data][:message]).to be_a(String)
  end

  it 'has empty parameters' do
    merchant = create(:merchant)

    get '/api/v1/merchants/find?name='
    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:data][:message]).to eq('Search cannot be empty')
  end
end
