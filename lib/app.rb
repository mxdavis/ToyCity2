require 'json'

def setup_files
    path = File.join(File.dirname(__FILE__), '../data/products.json')
    file = File.read(path)
    $products_hash = JSON.parse(file)
    $report_file = File.new("report.txt", "w+")
end

# Print "Sales Report" in ascii art
puts "  ____        _             ____                       _  " 
puts " / ___|  __ _| | ___  ___  |  _ \\ ___ _ __   ___  _ __| |_ "
puts " \\___ \\ / _` | |/ _ \\/ __| | |_) / _ \\ '_ \\ / _ \\| '__| __| "
puts "  ___) | (_| | |  __/\\__ \\ |  _ <  __/ |_) | (_) | |  | |_ "
puts " |____/ \\__,_|_|\\___||___/ |_| \\_\\___| .__/ \\___/|_|   \\__|"
puts "                                     |_|                   "

# Print today's date
puts "Today is #{Time.new}" 

# Print "Products" in ascii art
puts " ____                _            _    "   
puts "|  _ \\ _ __ ___   __| |_   _  ___| |_ ___ "
puts "| |_) | '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "|  __/| | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "|_|   |_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"


# For each product in the data set:
	# Print the name of the toy
	# Print the retail price of the toy
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
