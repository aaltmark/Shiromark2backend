require "json"
require "http"
require 'faker'

API_KEY = "hgPX5imSlIUMsrO6myqjZT09f_34q9CNOyzIYz8nHSu4UcYIKgTGMWqlfJtkmJSipSHuNpMpLxOwuUxMPNN60Um58yRNfK6rsr-iI3v3ECwLJZ0i3BufQdRqy_0zX3Yx"

API_HOST = "https://api.yelp.com"
SEARCH_PATH = "/v3/businesses/search"
BUSINESS_PATH = "/v3/businesses/"

DEFAULT_BUSINESS_ID = "6ZTUF9PxuTlLnE2N-wRNlA"
DEFAULT_TERM = "dinner"
DEFAULT_LOCATION = "New York City, NY"
SEARCH_LIMIT = 50

# Make a request to the Fusion search endpoint. Full documentation is online at:
# https://www.yelp.com/developers/documentation/v3/business_search
#
# term - search term used to find businesses
# location - what geographic location the search should happen
#
# Examples
#
#   search("burrito", "san francisco")
#   # => {
#          "total": 1000000,
#          "businesses": [
#            "name": "El Farolito"
#            ...
#          ]
#        }
#
#   search("sea food", "Seattle")
#   # => {
#          "total": 1432,
#          "businesses": [
#            "name": "Taylor Shellfish Farms"
#            ...
#          ]
#        }
#
# Returns a parsed json object of the request
#NEW COMMENT OUT 
def search(term=DEFAULT_TERM, location=DEFAULT_LOCATION)
  url = "#{API_HOST}#{SEARCH_PATH}"
  params = {
    term: term,
    location: location,
    limit: SEARCH_LIMIT
  }

  response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
  response.parse
end
#END NEW COMMENT OUT 

# Look up a business by a given business id. Full documentation is online at:
# https://www.yelp.com/developers/documentation/v3/business
# 
# business_id - a string business id
#
# Examples
# 
#   business("yelp-san-francisco")
#   # => {
#          "name": "Yelp",
#          "id": "yelp-san-francisco"
#          ...
#        }
#
# Returns a parsed json object of the request

#NEW COMMENT OUT 
def business(business_id=DEFAULT_BUSINESS_ID)
  url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"

  response = HTTP.auth("Bearer #{API_KEY}").get(url)
  response.parse
end

results = search()

id_array = results['businesses'].map do |result|
  result['id']
end

restsArray = id_array.map do |id|
    businessObj = business(id)
    priceVar = '$'
    
    if businessObj['price']
      priceVar = businessObj['price']
    end

    restaurantObj = {
        name: businessObj['name'],
        phone: businessObj['display_phone'],
        rating: businessObj['rating'],
        price: priceVar,
        location: businessObj['location']['display_address'].join(' | '),
        photos: businessObj['photos'],
        tags: businessObj['categories'].map {|tagObj| tagObj['title']}
    }
end

# # puts restsArray

restsArray.each do |restaurant|
  Restaurant.create(restaurant)
end

puts JSON.pretty_generate(business())
#END NEW COMMENT OUT 

#classmates seeds 
users = [
  {username: Faker::Superhero.name, name: "Alex Ortiz", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U0149P2DPGA-5bc46d19c029-512"},
  {username: Faker::Superhero.name, name: "Andrew Santos", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-UL8B585HP-14e7e4df1c70-512"},
  {username: Faker::Superhero.name, name: "Andy Agus", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-UQTV5GEFM-59b31a47e35f-512"},
  {username: Faker::Superhero.name, name: "Berel Levy", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U0149V71ZRR-179071fd3f16-512"},
  {username: Faker::Superhero.name, name: "Brandon Gubitosa", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U0149P2ATLJ-a175739d4005-512"},
  {username: Faker::Superhero.name, name: "Corey Lynch", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U011LC0U7GW-f7b87b95c922-512"},
  {username: Faker::Superhero.name, name: "Daniel Reyes", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U0136GZTQSG-77e66445bb6c-512"},
  {username: Faker::Superhero.name, name: "Dolly Desir", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U0130BRC3K4-9001c9b22325-512"},
  {username: Faker::Superhero.name, name: "Jeffrey Musselman", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-UMC62QVAM-019eb6bf04b1-512"},
  {username: Faker::Superhero.name, name: "Leamsi Escribano", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U0149P2CRNE-50a2d608ab6c-512"},
  {username: Faker::Superhero.name, name: "Malcolm Staso", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U014ZJ9F1K2-d9c4863dcd04-512"},
  {username: Faker::Superhero.name, name: "Maleeha Bhuiyan", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U0148BWV805-946025995b60-512"},
  {username: Faker::Superhero.name, name: "Maxwell Croy", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U014DQ3SKMK-8164c7778a8b-512"},
  {username: Faker::Superhero.name, name: "Maya Blevins", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U0149V711B5-b550a063d7f8-512"},
  {username: Faker::Superhero.name, name: "Melody Soriano", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U0149P29UH0-611bbf796682-512"},
  {username: Faker::Superhero.name, name: "Muhammad Hassan", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U014ZJ9C4HE-3e3623a4de5d-512"},
  {username: Faker::Superhero.name, name: "Paola Dolcemascolo", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-UUNMDGQHG-384b0c170392-512"},
  {username: Faker::Superhero.name, name: "Rebecca Rosenberg", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U014ZJ9E3RN-0006b89adbe7-512"},
  {username: Faker::Superhero.name, name: "Rudy Guerrero", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U013V17QKQF-b9866186602f-512"},
  {username: Faker::Superhero.name, name: "Shadman Ahmed", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U0149V6VD1R-25fe7ef5f450-512"},
  {username: Faker::Superhero.name, name: "Stephen Galvan", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U014ZJ9GY6L-aca36055b09d-512"},
  {username: Faker::Superhero.name, name: "Tashawn Williams", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U7PSME4DA-8b811931b3d9-512"},
  {username: Faker::Superhero.name, name: "Travis Prol", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U0149P2ES90-c5e480b910c1-512"},
  {username: Faker::Superhero.name, name: "Eric Kim", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U91CXSUN4-3bac0a7f6a08-512"},
  {username: Faker::Superhero.name, name: "Greg Dwyer", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U8H2RA3C1-643c8ce562ef-512"},
  {username: Faker::Superhero.name, name: "Andrew de la Vega", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-UTGL276L9-9b82a301560d-512"},
  {username: Faker::Superhero.name, name: "Anna Romsa", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U010KJG3FUG-b921e9ae0781-512"},
  {username: Faker::Superhero.name, name: "James Schoen", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-U013NFLSHGF-a62043ba0038-512"},
  {username: Faker::Superhero.name, name: "Julian Pormentilla", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-UTSAY91EY-6c2c4de59d92-512"},
  {username: Faker::Superhero.name, name: "Shobhit Ratan", location: "NYC", bio: Faker::Hipster.sentence, password: "123", image: "https://ca.slack-edge.com/T02MD9XTF-UTGL2F8TB-0c1149111a22-512"}
]
User.create(users)

60.times do
  Review.create(rating: rand(5), content: Faker::Restaurant.review, user_id: rand(30), restaurant_id: rand(50), title: Faker::Hipster.sentence(word_count: 3))
end 

# 40.times do 
#   Comment.create({user_id: rand(20), review_id: rand(60), content: Faker::Quote.yoda})
# end 