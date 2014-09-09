FactoryGirl.define do
  factory :item do
    title 'Ostrich'
    description 'That sweet, sweet ostrich meat.'
    price 32
  end

  factory :category do
    name "'MyCategory"
  end

  factory :order do
    delivery true
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