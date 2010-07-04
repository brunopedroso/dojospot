def calculate_relative_date(date_string) 
	if date_string
		date_string.strip!
		
		#Refact: use regexp and extract the number here...
		if date_string == "1 days ago"
			return Date.today - 1

		elsif date_string == "2 days ago"
				return Date.today - 2

		elsif date_string == "3 days ago"
				return Date.today - 3
				
		elsif date_string == "today" or date_string == "hoje"
				return Date.today

		elsif date_string == "tomorow" or date_string == "amanhã"
				return Date.today + 1

		else
				return date_string
		end
	end
end