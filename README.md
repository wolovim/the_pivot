[![Code Climate](https://codeclimate.com/github/ericfransen/dinner_dash/badges/gpa.svg)](https://codeclimate.com/github/ericfransen/dinner_dash)

```
                      I0 - Coming Soon!/ Wire Framing
                      I1 - Listing Items
                      /\
            Customer /  \ Admin
        Add to cart /    \ CRUD Items
   Delivery/pickup /      \ Categories
   Status/History /        \ Orders
                            \ Browsing
                             \ Inactive items
```

#Base Expectations
##Unauthenticated Users

###ALLOWED TO:
COMPLETED
* ~~Browse all items~~
* ~~Browse items by category~~
* ~~Add an item to my cart~~
* ~~View my cart~~
* ~~Remove an item from my cart~~
* ~~Increase the quantity of a item in my cart~~
* ~~Log in, which does not clear the cart~~

###NOT ALLOWED TO:

* ~~view another user’s private data (such as current order, etc.) ~~
* ~~Checkout (until they log in)~~
* ~~View the administrator screens or use administrator functionality~~
* ~~Make themselves an administrator~~

##Authenticated Non-Administrators

###ALLOWED TO:

* ~~do everything Unauthenticated Users can do except "log in"~~
* ~~log out~~
* ~~view their past orders with links to display each order~~

###ON THAT ORDER DISPLAY PAGE THERE ARE:
* ~~items with quantity ordered and line-item subtotals~~
* ~~links to each item description page~~
* ~~the current status of the order~~
* ~~order total price~~
* ~~date/time order was submitted~~
* ~~if completed or cancelled, display a timestamp when that action took place~~

###IF ANY ITEM IS RETIRED FROM THE MENU:
* ~~they can still access the item page~~
* ~~they cannot add it to a new cart~~

###NOT ALLOWED TO:
* ~~view another user’s private data (such as current order, etc.)~~
* ~~view the administrator screens or use administrator functionality~~
* ~~make themselves an administrator~~

##Administrators

###ALLOWED TO:

* ~~Create item listings including a name, description, price, and upload a photo~~
* ~~Modify existing items’ name, description, price, and photo~~
* ~~Create named categories for items (eg: "Small Plates")~~
* ~~ Assign items to categories or remove them from categories. Products can belong to more than one category.~~
* ~~Retire an item from being sold, which hides it from browsing by any non-administrator~~

###As an Admin, I can also view an order "dashboard" where I can:

* See a listing of all orders with:
* ~~the total number of orders by status~~
* ~~links for each individual order~~
* ~~filter orders to display by status type (for statuses "ordered", "paid", "cancelled", "completed")~~
* ~~link to transition to a different status:~~
* ~~link to "cancel" individual orders which are currently "ordered" or "paid"~~
* ~~link to "mark as paid" orders which are "ordered"~~
* ~~link to "mark as completed" individual orders which are currently "paid"~~
* Access details of an individual order, including:
* ~~Order date and time~~
*~~Purchaser full name and email address~~
For each item on the order:
* ~~Name linked to the item page~~
* ~~Quantity~~
* ~~Price~~
* ~~Line item subtotal~~
* ~~Total for the order~~
* ~~Status of the order~~
*  Update an individual order
*  View and edit orders; may change quantity or remove items from orders with the status of pending or paid
*  Change the status of an order according to the rules as outlined above

###NOT ALLOWED TO:

~~Modify any personal data aside from their own~~

##Data Validity
*There are several types of entities in the system, each with certain required data. Any attempt to create or modify a record with invalid attributes should return the user to the input form with a validation error indicating the problem along with suggestions how to fix it.*

###Item

*  ~~An item must have a title, description, and price.~~
*  ~~The title and description cannot be empty strings.~~
*  ~~The title must be unique for all items in the system~~
*  The price must be a valid decimal numeric value and greater than zero
*  ~~The photo is optional. If not present, a stand-in photo is used.~~
*  User

*  ~~A user must have a plausibly valid email address that is unique across all users~~
*  ~~A user must have a full name that is not blank~~
*  ~~A user may optionally provide a display name that must be no less than 2 characters long and no more than 32~~

###Order

*  ~~An order must belong to a user~~
*  ~~An order must be for one or more of one or more items currently being sold~~
*  An order is marked for pickup or delivery
*  If marked for delivery, an order has an associated address with street number, street, city, state, and zip

##Example Data
*To support the evaluation process, please make the following available via the rake db:seed task in your application:*

###Items
*  At least 20 items of varying prices
*  Some of the items should be attached to multiple categories

###Categories
*  At least 5 categories with a varying number of member items

###Orders
*  At least 10 sample orders, with at least two at each stage of fulfillment (ordered, completed, cancelled)

###Users
*  Normal user with full name "Rachel Warbelow", email address "demo+rachel@jumpstartlab.com", password of "password" and no display name
*  Normal user with full name "Jeff", email address "demo+jeff@jumpstartlab.com", password of "password" and display name "j3"
*  Normal user with full name "Jorge Tellez", email address "demo+jorge@jumpstartlab.com", password of "password" and display name "novohispano"
*  User with admin priviliges with full name "Josh Cheek", email address "demo+josh@jumpstartlab.com", password of "password", and display name "josh"

#Submission Guidelines
- *Your project must be "live" on the web for your evaluation. We recommend you deploy it on Heroku*
- *Your README file on GitHub should contain a link to your live site*
- *On the production site, the URL path /code should redirect the user to the GitHub repository*
