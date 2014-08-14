user_list = [
  ["Rachel", "Warbelow", "demo+rachel@jumpstartlab.com"],
  ["Jeff", "", "demo+jeff@jumpstartlab.com"],
  ["Jorge", "Tellez", "demo+jorge@jumpstartlab.com"],
  ["Josh", "Cheek", "demo+josh@jumpstartlab.com"]
]

user_list.each do |first_name, last_name, email|
  User.create(first_name: first_name, last_name: last_name, email: email)
end

item_list = [
  [ "Butterfly", "Delicious food item", 1],
  [ "Chub", "Delicious food item", 2 ],
  [ "Whooping Crane", "Delicious food item", 3 ],
  [ "Ferret", "Delicious food item", 4 ],
  [ "Flycatcher", "Delicious food item", 5 ],
  [ "Canada Lynx", "Delicious food item", 6 ],
  [ "Jumping Mouse", "Delicious food item", 7 ],
  [ "Mexican Spotted Owl", "Delicious food item", 20 ],
  [ "Pikeminnow", "Delicious food item", 15 ],
  [ "Plover", "Delicious food item", 15 ],
  [ "Lesser Prarie Chicken", "Delicious food item", 15 ],
  [ "Pawnee Skipper", "Delicious food item", 20 ],
  [ "Sucker", "Delicious food item", 13 ],
  [ "Tern", "Delicious food item", 13 ],
  [ "Golden-winged Warbler", "Delicious food item", 13 ],
  [ "Monomorium talbotae", "Delicious food item", 13 ],
  [ "Olive-sided Flycatcher", "Delicious food item", 17 ],
  [ "Rocky Mountain Capshell", "Delicious food item", 17 ],
  [ "Rusty Blackbird", "Delicious food item", 17 ],
  [ "Uncompahgre Fritillary Butterfly", "Delicious food item", 17 ]
]

item_list.each do |title, description, price|
  Item.create( title:       title,
               description: description,
               price:       price)
end

category_list = [
  "Snails",
  "Breakfast",
  "Bugs",
  "Birds",
  "Cute",
  "Family Style",
  "Local",
  "Animal Style",
  "Gluten Free"
]

category_list.each do |name|
  Category.create( name: name )
end

items = Item.all
categories = Category.all

items.each do |item|
  item.categories << categories.sample
  item.categories << categories.sample
end


# Items
# At least 20 items of varying prices
# Some of the items should be attached to multiple categories
# Categories
# At least 5 categories with a varying number of member items
# Orders
# At least 10 sample orders, with at least two at each stage of fulfillment (ordered, completed, cancelled)
# Users
# Normal user with full name "Rachel Warbelow", email address "demo+rachel@jumpstartlab.com", password of "password" and no display name
# Normal user with full name "Jeff", email address "demo+jeff@jumpstartlab.com", password of "password" and display name "j3"
# Normal user with full name "Jorge Tellez", email address "demo+jorge@jumpstartlab.com", password of "password" and display name "novohispano"
# User with admin priviliges with full name "Josh Cheek", email address "demo+josh@jumpstartlab.com", password of "password", and display name "josh"
