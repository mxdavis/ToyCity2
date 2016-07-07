require 'json'
require 'pry'
require 'artii'

def start
  setup_files # load, read, parse, and create the files
  create_report # create the report!
  shortened_names
end
def setup_files
    path = File.join(File.dirname(__FILE__), '../data/products.json')
    file = File.read(path)
    $products_hash = JSON.parse(file)
    $report_file = File.new("report.txt", "w+")
end

def create_report
  header('Sales Report')
  todays_date
  linebreak
  header('Products')
  name_and_price_of_toy
  total_num_purchases
  avg_price
  avg_discount
  print_avg_price_and_avg_discount
  print_total_sales_and_purchases
  header('Brands')
  $report_file.close
end

# Print "Sales Report" in ascii art

def shortened_names
	$toys = toys = products_hash["items"]

def header(title)
	#print in ASCII
	title_ascii = Artii::Base.new
	$report_file.puts title_ascii.asciify(title)
	#add linebreak
	linebreak
end



# Print today's date
def todays_date
	$report_file.puts "Today is #{Time.new}" 
end

def linebreak
	$report_file.puts "==================================="
end
# Print "Products" in ascii art


# For each product in the data set:
	# Print the name of the toy
    # Print the retail price of the toy
    def name_and_price_of_toy
    	$report_file.puts "Items and Price"
    	$report_file.puts "============================"
    	$toys.each do |item|
    		$report_file.puts "#{item["title"]} costs $#{item["full-price"]}"
    	end
    end
	# Calculate and print the total number of purchases
	# Calculate and print the total amount of sales
	def total_num_purchases
		$sumofsales = 0
		$numpurchases = 0
		$toys.each do |item|
			$totalsales = 0
			$totalpurchases = 0
			item["purchases"].each do |purchase|
				$sumofsales += purchase["price"]
				$totalsales += purchase["price"]
				$numpurchases += 1
				$totalpurchases += 1
			end
		end
	end
	# Calculate and print the average price the toy sold for
	def avg_price
		$sumofsales / $numpurchases
	end
	# Calculate and print the average discount (% or $) based off the average sales price
	def avg_discount
		$toys.each do |item|
			$costprice = item["full-price"].to_f
		end
		(100.00 * (($costprice - avg_price) / $costprice)).round(2)
	end
	
	def print_avg_price_and_avg_discount
		$toys.each do |item|
			$report_file.puts "============================"
			$report_file.puts "#{$numpurchases} #{item["title"]} were sold for a total of $#{$sumofsales} with an average price of $#{avg_price}. The full price is $#{$costprice}. The average discount for #{item["title"]} was #{avg_discount}%"
		end
	end

	def print_total_sales_and_purchases
		$report_file.puts "============================"
		$report_file.puts "Total sales were $#{$totalsales} and total purchases #{$totalpurchases}"
	end

# Print "Brands" in ascii art



start
