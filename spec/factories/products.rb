FactoryGirl.define do
  factory :product do
    title   { Faker::Commerce.product_name }
    articul { Faker::Commerce.promotion_code }
    price   { Faker::Commerce.price }
  end
end
