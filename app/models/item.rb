class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items, dependent: :destroy
  validates_presence_of :merchant_id

  def self.all_items_search(items)
    where('name ILIKE ?', "%#{items}%").order(:name)
  end

  def self.item_search(item)
    where('name ILIKE ?', "%#{item}%").order(:name).limit(1)
  end

  def self.minimum_price(min)
    where("unit_price >= #{min}")
  end

  def self.maximum_price(max)
    where("unit_price <= #{max}")
  end

  def self.min_and_max_price(max, min)
    # where("unit_price >= #{min} AND unit_price <= #{max}")
    where(unit_price: min..max)
  end
end
