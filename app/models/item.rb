class Item < ApplicationRecord
  belongs_to :merchant


  validates_presence_of :merchant_id
end
