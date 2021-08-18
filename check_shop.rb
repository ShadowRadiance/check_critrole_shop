require 'open-uri'
require 'nokogiri'
require 'json'

url = "https://canada.critrole.com/collections/all-products/products/baileys-dice-bag-of-hoarding?variant=36226702999718"
doc = Nokogiri::HTML5(URI.open(url))
script_tag = doc.at_css("#ProductJson-1")
json = script_tag.inner_html
object = JSON.parse(json)

if object['available']
  puts "Product in Stock: #{url}"
else
  puts "Product out of Stock"
end
