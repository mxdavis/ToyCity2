require 'json'
require 'pry'
require 'artii'

def start
  setup_files # load, read, parse, and create the files
  create_report # create the report!
end
def setup_files
    path = File.join(File.dirname(__FILE__), '../data/products.json')
    file = File.read(path)
    $products_hash = JSON.parse(file)
    $report_file = File.new("../ report.txt", "w+")
end

def create_report
  print_ascii('Sales Report')
  todays_date
  linebreak
  print_ascii('Products')
  name_and_price_of_toy
  print_products_calculations
  print_ascii('Brands')
  print_brand_calculations
  end_report
  $report_file.close
end

# Print "Sales Report" in ascii art
# Print "Products" in ascii art
# Print "Brands" in ascii art

def print_ascii(title)
	title_ascii = Artii::Base.new
	$report_file.puts title_ascii.asciify(title)
	linebreak
end

# Print today's date
def todays_date
	$report_file.puts "Today is #{Time.new}" 
end

def linebreak
	$report_file.puts "================================================================================================"
end


# For each product in the data set:
	# Print the name of the toy
    # Print the retail price of the toy
    def name_and_price_of_toy
    	$report_file.puts "Items and Price"
    	linebreak
    	$products_hash["items"].each do |item|
    		$report_file.puts "#{item["title"]} costs $#{item["full-price"]}"
    	end
    end
	
	def print_products_calculations
totalsales = 0
  totalpurchases = 0
  $products_hash["items"].each do |item|
    # Calculate and print the total number of purchases 
    # Calculate and print the total amount of sales 
    sumofsales = 0
    numpurchases = 0
    item["purchases"].each do |purchase|
      sumofsales += purchase["price"]
      totalsales += purchase["price"]
      numpurchases += 1
      totalpurchases += 1
    end
    # Calculate and print the average price the toy sold for 
    avgprice = sumofsales / numpurchases
    # Calculate and print the average discount (% or $) based off the average sales price 
    costprice = item["full-price"].to_f
    $report_file.puts "#{numpurchases} #{item["title"]} were sold for a total of $#{sumofsales} with an average price of 
    $#{avgprice}. The full price is $#{costprice}. The average discount for #{item["title"]} was 
    #{(100.00 * ((costprice - avgprice) / costprice)).round(2)}%"
    linebreak
  end
  $report_file.puts "Total sales were $#{totalsales} and total purchases #{totalpurchases}"
  linebreak
	end


# Print "Brands" in ascii art

def print_brand_calculations
	brandhash = {}
	brandsunique = $products_hash["items"].map { |toy| toy["brand"] }.uniq
 # Count and print the number of the brand's toys we stock
 brandsunique.each do |brand|
 	brandhash[brand] = {count: 0, stock: 0, price: 0}

     # Calculate and print the total revenue of all the brand's toy sales combined
     $products_hash["items"].each do |item|
     	if brand == item["brand"]
     		brandhash[brand][:stock] += item["stock"]
     		item["purchases"].each do |purchase|
     			brandhash[brand][:count] += 1
     			brandhash[brand][:price] += purchase["price"].to_f
     		end
     	end
     end
  # Calculate and print the average price of the brand's toys
  avgpricebrand = brandhash[brand][:price] / brandhash[brand][:count]
  $report_file.puts "#{brand} has #{brandhash[brand][:stock]} toys in stock. The average price of the #{brandhash[brand][:count]} toys sold by #{brand} is $#{avgpricebrand.round(2)} and the total revenue is $#{brandhash[brand][:price].round(2)}"
  linebreak
end
end

def end_report
	$report_file.puts "THIS IS THE END OF THE REPORT"
	linebreak
end


start
