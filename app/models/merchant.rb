class Merchant < ApplicationRecord
  has_many :items

  def self.merchant_search(merchant)
    where('name ILIKE ?', "%#{merchant}%").order(:name).limit(1)
  end
end
