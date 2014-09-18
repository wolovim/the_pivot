FactoryGirl.define do
  sequence(:title) { |n| "MyTitle #{n}" }

  factory :item do
    title { generate(:title) }
    description 'MyDesc'
    bathroom 'Private'
    people_per_unit 1
    price 32
  end

  factory :item_image do
    image_file_name
  end

  factory :address do
    item_id 80
    street_1 "1510 Blake"
    street_2 "1624 Market"
    city "Denver"
    state "CO"
    zip "80202"
  end

  factory :category do
    name "'MyCategory"
  end

  factory :order do
    ignore do
      items nil
    end

    after :create do |object, evaluator|
      if evaluator.items
        evaluator.items.each do |item|
          create(:order_item, order: object, item: item)
        end
      end
    end
  end

  factory :order_item do
    order
    item
  end

  sequence :email do |n|
    "email#{n}@example.com"
  end

  factory :user do
    first_name "John"
    last_name  "Doe"
    email
    password   "123456789"
    role       "default"

    trait :admin do
      role "admin"
    end
  end
end
