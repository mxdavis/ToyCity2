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
    $report_file = File.new("../report.txt", "w+")
end

def create_report
  print_ascii('Sales Report')
  calculate_and_print_todays_date
  puts_linebreak
  print_ascii('Products')
  loop_through_products_and_print
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
	puts_linebreak
end

# Print today's date
def calculate_and_print_todays_date
	timenow = Time.new
	printtime = timenow.strftime("Printed on %A, %d %b %Y %l:%M %p")
	$report_file.puts printtime
end

def puts_linebreak
	$report_file.puts "================================================================================================"
end

def loop_through_products_and_print
  $products_hash["items"].each do |toy|
    $report_file.puts "#{name_of_toy(toy)} costs $#{price_of_toy(toy)}. #{total_amount_sold(toy)} #{name_of_toy(toy)} were sold for a total of $#{total_sales(toy)} with an average discount price of $#{average_price(toy)}. The average discount was #{average_discount(toy)}. #{puts_linebreak}"
  end
end

# For each product in the data set:
	# Print the name of the toy
    # Print the retail price of the toy
def name_of_toy(toy)
  return "#{toy["title"]}"
end

def price_of_toy(toy)
  return toy["full-price"].to_f
end

def total_amount_sold(toy)
  return "#{toy["purchases"].length}".to_i
end

def total_sales(toy)
  total_sales = 0
  toy["purchases"].each { |purchase| total_sales = total_sales += purchase["price"]}
  return total_sales.to_f
end

def average_price(toy)
  return total_sales(toy) / total_amount_sold(toy)
end

def average_discount(toy)
  return "#{(100.00 * ((price_of_toy(toy) - average_price(toy)) / price_of_toy(toy))).round(2)}%"
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
  puts_linebreak
end
end

def end_report
	$report_file.puts "THIS IS THE END OF THE REPORT"
	puts_linebreak
end


start
