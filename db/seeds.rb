require "json"
require "http"

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

results = search()

id_array = results['businesses'].map do |result|
    result['id']
end
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
def business(business_id=DEFAULT_BUSINESS_ID)
  url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"

  response = HTTP.auth("Bearer #{API_KEY}").get(url)
  response.parse
end

id_array.each do |id|
    businessObj = business(id)
    restaurantObj = {
        name: businessObj['name'],
        phone: businessObj['display_phone'],
        rating: businessObj['rating'],
        location: businessObj['location']['display_address'].join(' | '),
        photos: businessObj['photos'],
        tags: businessObj['categories'].map {|tagObj| tagObj['title']}
    }
    Restaurant.create(restaurantObj)
end

# puts JSON.pretty_generate(business())