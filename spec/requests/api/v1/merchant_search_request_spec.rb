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

    
  it 'counts all of the items sold' do 
    merchant1 = Merchant.create!(name: 'Joe Schmoe')
    merchant2 = Merchant.create!(name: 'Sean John')
    merchant3 = Merchant.create!(name: 'Cracker Jack')
    customer = Customer.create!(first_name: 'Weather', last_name: 'Man')

    item1 = merchant1.items.create!(name: 'Dented Hubcap', description: 'Benz hubcap dented by Leslie Nielson', unit_price: 1)
    item2 = merchant1.items.create!(name: 'Muscle Cap', description: 'Placebo for those who go to the gym as their New Years Resolution', unit_price: 1)
    item3 = merchant1.items.create!(name: 'RGB Mousepad', description: 'Goes great with other rgb accessories to blind your eyes further', unit_price: 1)
    item4 = merchant2.items.create!(name: '1940 Camel Cigarettes', description: 'Extracted from a US MRE', unit_price: 1)
    item5 = merchant2.items.create!(name: 'Non-Alcoholic Beer', description: 'Great for those who live in a dry county', unit_price: 1)
    item6 = merchant3.items.create!(name: '1st Gen Hard Drive', description: 'First ever hard drive the size of a sedan', unit_price: 1)
    invoice1 = customer.invoices.create!(customer_id: customer.id, merchant_id: merchant1.id, status: 'shipped')
    invoice2 = customer.invoices.create!(customer_id: customer.id, merchant_id: merchant2.id, status: 'shipped')
    invoice3 = customer.invoices.create!(customer_id: customer.id, merchant_id: merchant3.id, status: 'shipped')
    invoice_item_1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 1, unit_price: 1)
    invoice_item_2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 1, unit_price: 1)
    invoice_item_3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice1.id, quantity: 1, unit_price: 1)
    invoice_item_4 = InvoiceItem.create!(item_id: item4.id, invoice_id: invoice2.id, quantity: 1, unit_price: 1)
    invoice_item_5 = InvoiceItem.create!(item_id: item5.id, invoice_id: invoice2.id, quantity: 1, unit_price: 1)
    invoice_item_6 = InvoiceItem.create!(item_id: item6.id, invoice_id: invoice3.id, quantity: 1, unit_price: 1)
    transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: '333333333', credit_card_expiration_date: '999', result: 'success')
    transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: '333333333', credit_card_expiration_date: '999', result: 'success')
    transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: '333333333', credit_card_expiration_date: '999', result: 'success')


    get '/api/v1/merchants/most_items?quantity=2'

    expect(response).to be_successful
    expect(Merchant.most_items_sold_by_count(2)).to eq([merchant1, merchant2])
  end
end
