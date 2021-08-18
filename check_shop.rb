require 'open-uri'
require 'nokogiri'
require 'json'
require 'optparse'

class Application
  Product = Struct.new(:json) do
    def available?
      json['available']==true
    end
  end
  
  DEFAULT_URL = "https://canada.critrole.com/collections/all-products/products/baileys-dice-bag-of-hoarding?variant=36226702999718"
  
  def initialize
    @url = DEFAULT_URL
  end
  
  def run
    parse_command_line
    puts availability
  rescue JSON::ParserError
    puts "Could not parse JSON object at #ProductJson-1. Is this a CritRole url?"
  rescue Errno::ENOENT
    puts "Unrecognized URL"
  rescue SocketError
    puts "Network not available"
  rescue => e
    puts e
  end
  
  private
  
  def parse_command_line
    if ARGV.length > 0
      @url = ARGV[0]
    end
  end
  
  def availability
    if product.available?
      "Product in Stock: #{@url}" 
    else
      "Product out of Stock"
    end
  end
  
  def product
    Product.new hash_from_json
  end
  
  def hash_from_json
    JSON.parse(element.inner_html).tap do |object|
      raise JSON::ParserError unless object.is_a?(Hash)
      raise JSON::ParserError unless object.key?('available')
    end
  end
  
  def element
    document.at_css("#ProductJson-1").tap do |e|
      raise "Could not parse #{@url} - is this a CritRole url?" if e.nil?
    end
  end
  
  def document
    Nokogiri::HTML5(URI.open(@url))
  end  
end

Application.new.run
