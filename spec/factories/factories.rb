FactoryGirl.define do
  factory :item do
    title 'MyTitle'
    description 'MyDesc'
    bathroom 'private'
    people_per_unit 1
    price 32
  end

  factory :category do
    name "'MyCategory"
  end

  factory :order do
  end

  factory :order_item do
    order
    item
  end

  factory :user do
    first_name "John"
    last_name  "Doe"
    email      "j@example.com"
    password   "123456789"
    role       "admin"
  end
end