class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices 
  has_many :invoice_items, through: :invoices

  def self.merchant_search(merchant)
    where('name ILIKE ?', "%#{merchant}%").order(:name).limit(1)
  end

  def self.all_merchants_search(merchants)
    where('name ILIKE ?', "%#{merchants}%")
  end

  def self.top_merchants_by_revenue(number)
    Merchant.joins(invoices: [:invoice_items, :transactions])
            .where(transactions: {result: "success"}, invoices: {status: 'shipped'})
            .select('merchants.name, merchants.id, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
            .order(revenue: :desc)
            .group(:id)
            .limit(number)
  end
end

