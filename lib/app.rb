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
    	$linebreak = $report_file.puts "============================"
    	$linebreak
    	$toys = $products_hash["items"]
    	$toys.each do |item|
    		$report_file.puts "#{item["title"]} costs $#{item["full-price"]}"
    	end
    end
	# Calculate and print the total number of purchases
	# Calculate and print the total amount of sales
	# Calculate and print the average price the toy sold for
	# Calculate and print the average discount (% or $) based off the average sales price

# Print "Brands" in ascii art

# For each brand in the data set:
	# Print the name of the brand
	# Count and print the number of the brand's toys we stock
	# Calculate and print the average price of the brand's toys
	# Calculate and print the total sales volume of all the brand's toys combined

start
