FactoryGirl.define do
  factory :product do
    title   { Faker::Commerce.product_name }
    articul { Faker::Number.hexadecimal(12) }
    price   { Faker::Commerce.price }
  end
end
