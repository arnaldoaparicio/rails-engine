class MerchantSerializer
  include JSONAPI::Serializer
  attributes :id, :name

  has_many :items

  attribute :num_items do |object|
    object.items.count
  end
end
