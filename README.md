# TravelHome

Built for the (Turing School of Software and Design)[http://turing.io], 
TravelHome is a site for people to rent out lodging (think airbnb, couchsurfing).  

Users can function both as hosts and travellers.  An example workflow may look 
something like this:

- A traveler comes to the site and browses available listings
- They request to book a listing, at which point the host is notified by email
- The host has the option to confirm or deny a particular booking request
- Should the request be accepted, confirmation is sent to both host and traveler and payment proceeds

More specifically:

Hosts can:

- Create and manage listings
- Confirm and deny booking requests
- See a history of successful visits

Travelers can:

- Browse all listings or listings for a specific host
- Filter by things like price and available dates
- Maintain multiple booking requests over a single order

If you'd like to run the code locally:

`$ git clone https://github.com/marcgarreau/the_pivot.git && cd the_pivot`  
`$ bundle`  
`$ rake db:create db:migrate db:seed`

or, more concisely

`$ rake db:setup`

Run tests with

`$ bundle exec rspec`

Postgresql is used in the development and test environments as well as production so
out of the box you are required to have postgres installed and configured correctly
locally.