require 'json'
require 'pry'

def start
  setup_files # load, read, parse, and create the files
  create_report # create the report!
end
def setup_files
    path = File.join(File.dirname(__FILE__), '../data/products.json')
    file = File.read(path)
    $products_hash = JSON.parse(file)
    $report_file = File.new("report.txt", "w+")
end

def create_report
  sales_report_ascii
  todays_date
  products_ascii
  name_and_price_of_toy
  total_num_purchases
  avg_price
  avg_discount
  print_avg_price_and_avg_discount
  print_total_sales_and_purchases
  $report_file.close
end

# Print "Sales Report" in ascii art
def sales_report_ascii
$report_file.puts "  ____        _             ____                       _  " 
$report_file.puts " / ___|  __ _| | ___  ___  |  _ \\ ___ _ __   ___  _ __| |_ "
$report_file.puts " \\___ \\ / _` | |/ _ \\/ __| | |_) / _ \\ '_ \\ / _ \\| '__| __| "
$report_file.puts "  ___) | (_| | |  __/\\__ \\ |  _ <  __/ |_) | (_) | |  | |_ "
$report_file.puts " |____/ \\__,_|_|\\___||___/ |_| \\_\\___| .__/ \\___/|_|   \\__|"
$report_file.puts "                                     |_|                   "
end
# Print today's date
def todays_date
	$report_file.puts "Today is #{Time.new}" 
end

# Print "Products" in ascii art
def products_ascii
$report_file.puts " ____                _            _    "   
$report_file.puts "|  _ \\ _ __ ___   __| |_   _  ___| |_ ___ "
$report_file.puts "| |_) | '__/ _ \\ / _` | | | |/ __| __/ __|"
$report_file.puts "|  __/| | | (_) | (_| | |_| | (__| |_\\__ \\"
$report_file.puts "|_|   |_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
end

# For each product in the data set:
	# Print the name of the toy
    # Print the retail price of the toy
    def name_and_price_of_toy
    	$report_file.puts "Items and Price"
    	$report_file.puts "============================"
    	$products_hash["items"].each do |item|
    		$report_file.puts "#{item["title"]} costs $#{item["full-price"]}"
    	end
    end
	# Calculate and print the total number of purchases
	# Calculate and print the total amount of sales
	def total_num_purchases
		$sumofsales = 0
		$numpurchases = 0
		$products_hash["items"].each do |item|
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
		$products_hash["items"].each do |item|
			$costprice = item["full-price"].to_f
		end
		(100.00 * (($costprice - avg_price) / $costprice)).round(2)
	end
	
	def print_avg_price_and_avg_discount
		$products_hash["items"].each do |item|
			$report_file.puts "============================"
			$report_file.puts "#{$numpurchases} #{item["title"]} were sold for a total of $#{$sumofsales} with an average price of $#{avg_price}. The full price is $#{$costprice}. The average discount for #{item["title"]} was #{avg_discount}%"
		end
	end

	def print_total_sales_and_purchases
		$report_file.puts "============================"
		$report_file.puts "Total sales were $#{$totalsales} and total purchases #{$totalpurchases}"
	end

# Print "Brands" in ascii art

# For each brand in the data set:
	# Print the name of the brand
	# Count and print the number of the brand's toys we stock
	# Calculate and print the average price of the brand's toys
	# Calculate and print the total sales volume of all the brand's toys combined

start
