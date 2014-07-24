class Student
	attr_accessor :student_details
	def initialize
		@student_details = "$"
	end	
	def add name, mark
		@student_details = student_details + name.to_s + '$' + mark.to_s + '$'
	end
	def show
		puts "\nStudnet Details"
		i = 1
		student_details.scan(/(?<=\$)(.*?)(?=\$)/).each do |val|
			print val.first.to_s + "  "
			puts "" if(i%2==0)
			i += 1
		end
	end
	def return_mark name
		print "\nMark of #{name} is : "
		student_details.scan(/(?<=\$)(.*?)(?=\$)/).each_cons(2) do |val,next_val|
			print next_val.first if val.first == name
		end
	end
	def delete_student name
		p student_details.gsub!( Regexp.new("(\\$)(#{name}?)(\\$)(\\d\\d)"), "")
	end
	def replace_name_with_fname
		puts "\n\nNames replaced with first name"
		@student_details = student_details.split('$').map! { |val| val = val.split(' ').first }.join('$')
		@student_details += '$'
	end
	def marks_greater_than mark
		puts "\n\nStudnts with mark greater than #{mark} is: "
		student_details.scan(/(?<=\$)(.*?)(?=\$)/).each_cons(2) do |val, next_val|
			print val.first.to_s + " \n" if next_val.first.to_i >= mark
		end
	end
	def descending_order_of_marks
		puts "\nStudent list in descending order of marks is : "
		Hash[*student_details.scan(/(?<=\$)(.*?)(?=\$)/).flatten].sort_by{|k,v| v}.reverse.each { |v| p v[0] +"  "+ v[1] }    	 
	end
	def search_with_part_of_string string 
		puts "\nStudent details of those with search term '#{string}'"
		student_details.scan(/(?<=\$)(.*?)(?=\$)/).each_cons(2) do |val,next_val|
			puts val.first + '  ' + next_val.first if val.first.include? string
		end
	end

end

s = Student.new
s.add "rohit kishore", "73"
s.add "basil bose",    "82"
s.add "johit mathew",   "83"
s.add "arun varghese", "45"
s.show
s.return_mark "arun varghese"
s.replace_name_with_fname
s.marks_greater_than 70
s.descending_order_of_marks
s.search_with_part_of_string "hit"