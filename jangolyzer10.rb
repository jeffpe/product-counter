# analyze the jango smtp downloads
# The next time I do this use SQL or someting like that. This is getting ridiculous.



# load in the required libraries
require "csv"
require "date"

# set the names of the csv files
jangomds_file = "jango_mds.csv"
jangosales_file = "jango_sales.csv"
output_file_name = "jango_output.csv"

# set the parameters of the paypal csv file. First line/field = 0 
jango_start_line = 1
jango_open = 4
jango_click = 5


# final output variables
jangomds_sent = 0
jangomds_opens = 0 
jangomds_clicks = 0 
jangosales_sent = 0 
jangosales_opens = 0
jangosales_clicks = 0 

# Convert CSV to ARRAY, input csv_name, return the array
def csv_to_array(csv_name)
	CSV.read(csv_name)
end



# Count the Sent, Open, Clicks
def jango_counter(array, length, start_line, open, click)
	sent, opens, clicks = 0, 0, 0
	sent = length-1
	for i in (start_line..(length-1))
		open_field = array[i][open]
		click_field = array[i][click]
		if (open_field != nil) 
			opens +=1
		end
		if (click_field != nil) 
			clicks += 1
		end
	end
	return sent, opens, clicks
end

#----------------------------------------------------------------
begin

jangomds_array = csv_to_array(jangomds_file)
jangosales_array = csv_to_array(jangosales_file)

jangomds_length = jangomds_array.length()
jangosales_length = jangosales_array.length()

jangomds_sent, jangomds_opens, jangomds_clicks = jango_counter(jangomds_array, jangomds_length, jango_start_line, jango_open, jango_click)

jangosales_sent, jangosales_opens, jangosales_clicks = jango_counter(jangosales_array, jangosales_length, jango_start_line, jango_open, jango_click)

puts "Enter the MD Jango bounces for the period (integer please 0-infinity):"
jangomds_bounces = STDIN.gets.to_i
puts "Enter the Sales Jango bounces for the period (integer please 0-infinity):"
jangosales_bounces = STDIN.gets.to_i


puts "JANGO MD SENDS"
puts jangomds_sent, jangomds_opens, jangomds_clicks
puts jangomds_opens/jangomds_sent.to_f
puts jangomds_clicks/jangomds_sent.to_f
puts jangomds_bounces/jangomds_sent.to_f
puts "--------------------------------------------------"
puts "JANGO SALES SENDS"
puts jangosales_sent, jangosales_opens, jangosales_clicks
puts jangosales_opens/jangosales_sent.to_f
puts jangosales_clicks/jangosales_sent.to_f
puts jangosales_bounces/jangomds_sent.to_f

#--------------------------------------------------------------


####################
# Output CSV File
###################
CSV.open(output_file_name, "wb") do |csv|
	csv << ["Jango Desktop Blast Results -- MD BLAST and SALES BLAST"]
	csv << [Date.today]
	csv << []
	csv << ["MD BLAST RESULTS"]
	csv << ["Sent",jangomds_sent]
	csv << ["Open Rate",jangomds_opens/jangomds_sent.to_f]
	csv << ["Click Rate",jangomds_clicks/jangomds_sent.to_f]
	csv << ["Bounce Rate",jangomds_bounces/jangomds_sent.to_f]
	csv << []
	csv << ["-----------------------------------"]
	csv << []
	csv << ["SALES BLAST RESULTS"]
	csv << ["Sent",jangosales_sent]
	csv << ["Open Rate",jangosales_opens/jangosales_sent.to_f]
	csv << ["Click Rate",jangosales_clicks/jangosales_sent.to_f]
	csv << ["Bounce Rate",jangosales_bounces/jangosales_sent.to_f]
	end
	

end



