require 'open-uri'
require 'nokogiri'
require 'json'
require 'optparse'

class Application
  Options = Struct.new(:url)
  DEFAULT_URL = "https://canada.critrole.com/collections/all-products/products/baileys-dice-bag-of-hoarding?variant=36226702999718"
  
  def initialize
    @url = DEFAULT_URL
  end
  
  def run
    parse_command_line
    check_url
  end
  
  def check_url
    doc = Nokogiri::HTML5(URI.open(@url))
    script_tag = doc.at_css("#ProductJson-1")
    json = script_tag.inner_html
    object = JSON.parse(json)

    if object['available']
      puts "Product in Stock: #{@url}"
    else
      puts "Product out of Stock"
    end
    
  end
  
  private
  
  def parse_command_line
    if ARGV.length > 0
      @url = ARGV[0]
    end
  end
end

Application.new.run
