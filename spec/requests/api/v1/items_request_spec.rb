require 'rails_helper'

describe 'Item API' do
  it 'sends a list of merchants' do
    merchant = create(:merchant)
    create_list(:item, 3, merchant: merchant)


    get '/api/v1/items'

    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)
    expect(items.count).to eq(3)

    items.each do |item|
    end
  end
end
