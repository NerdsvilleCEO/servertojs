#!/usr/bin/ruby1.9.1

#####################################################################################################################
#
#   TODO LIST
#   
#####################################################################################################################


require "cgi"
require "cgi/session"
require 'sequel'
require 'pg'
require "time"
require "date"


# Variable setup for 'pg' as it is easier for output
connhash = { :host=>'localhost', :user=>'my_user', :password=>'my_password', :dbname=>'database' }
db = PGconn.connect( connhash )

# Variable setup for 'sequel' as it is easier for input
DB = Sequel.postgres(:host=>'localhost', :user=>'my_user', :password=>'my_password', :database=>'database', :charset=>'UTF-8')
Sequel.datetime_class = DateTime


def chopper(input)
start_cut = 2
input=input.inspect
length=input.length
end_cut = length-4
input=input[start_cut, end_cut]
# puts input
end


cgi = CGI.new("html4")
cgi.keys

h = cgi.params

notes = h['notes']
sanity = h['sanity']
transaction_type = h['transaction_type']
table_name = h['table_name']
primary_key = h['primary_key']
row1 = h['row1']
row2 = h['row2']
row3 = h['row3']
row4 = h['row4']
row5 = h['row5']
row6 = h['row6']
row7 = h['row7']
row8 = h['row8']
row9 = h['row9']
row10 = h['row10']
row11 = h['row11']

notes = chopper(notes)
primary_key = chopper(primary_key)
sanity = chopper(sanity)
transaction_type = chopper(transaction_type)
table_name = chopper(table_name)
row1 = chopper(row1)
row2 = chopper(row2)
row3 = chopper(row3)
row4 = chopper(row4)
row5 = chopper(row5)
row6 = chopper(row6)
row7 = chopper(row7)
row8 = chopper(row8)
row9 = chopper(row9)
row10 = chopper(row10)
row11 = chopper(row11)


cgi = CGI.new("html4")
cgi.keys
sess = CGI::Session.new( cgi,  "session_key" => "kleios_login",
                               "session_id" => "9650",
                              "session_expires" => Time.now + 1,
                               "prefix" => "web-session.")
                                
cgi.out{
  cgi.html{

  }
}

#####################################################################################
#
# Let's Do Some Security. We're going to blacklist stuff because that's easier to
# program.
#
#####################################################################################

### First check for the correct tables. So far we only need to blacklist access to the
### session and user tables.

if ["users","sessions"].include? table_name

puts "<div id=\"Error Message\"> You are not allowed to access the users or session table. This violation of our rules has been reported to the site administrators.</div>"

abort

end




row1_data = row1
row2_data = row2
row3_data = row3
row4_data = row4
row5_data = row5
row6_data = row6
row7_data = row7
row8_data = row8
row9_data = row9
row10_data = row10
row11_data = row11



# puts "<p>Chopped Primary Key", primary_key.inspect, "<br>"

# puts "I'm Working"
puts "<br><br>"
puts "<div id=\"sanity\">", sanity, "</div>"
puts "<div id=\"primary_key\">", primary_key, "</div>"
puts "<div id=\"table_name\">", table_name, "</div>"

# primary_key = "1"

#####################################################################################
#
# Look for the information in the database
#
#####################################################################################


DB.fetch("SELECT * FROM #{table_name} WHERE primary_key = \'#{primary_key}\'") do |row|
row1_data = row[:"#{row1}"]
row2_data = row[:"#{row2}"]
row3_data = row[:"#{row3}"]
row4_data = row[:"#{row4}"]
row5_data = row[:"#{row5}"]
row6_data = row[:"#{row6}"]
row7_data = row[:"#{row7}"]
row8_data = row[:"#{row8}"]
row9_data = row[:"#{row9}"]
row10_data = row[:"#{row10}"]

end

puts "<div id=\"#{row1}\">", row1_data, "</div>"
puts "<div id=\"#{row2}\">", row2_data, "</div>"
puts "<div id=\"#{row3}\">", row3_data, "</div>"
puts "<div id=\"#{row4}\">", row4_data, "</div>"
puts "<div id=\"#{row5}\">", row5_data, "</div>"
puts "<div id=\"#{row6}\">", row6_data, "</div>"
puts "<div id=\"#{row7}\">", row7_data, "</div>"
puts "<div id=\"#{row8}\">", row8_data, "</div>"
puts "<div id=\"#{row9}\">", row9_data, "</div>"
puts "<div id=\"#{row10}\">", row10_data, "</div>"

abort
