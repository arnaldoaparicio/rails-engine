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
end
