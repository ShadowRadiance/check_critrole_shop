require 'open-uri'
require 'nokogiri'
require 'json'

doc = Nokogiri::HTML5(URI.open("https://canada.critrole.com/collections/all-products/products/baileys-dice-bag-of-hoarding?variant=36226702999718"))
script_tag = doc.at_css("#ProductJson-1")
json = script_tag.inner_html
object = JSON.parse(json)

puts "#{object['available']}"

