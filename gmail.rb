require 'gmail'

NO_OF_MESSAGES_TO_SAVE = 5
USERNAME = ''
PASSWORD = ''


class Mailer
	attr_accessor :gmail, :subject, :date
	def initialize
		@subject = []
		@date = []
		@gmail = Gmail.new( USERNAME, PASSWORD);
	end
	def save_to_file num
		gmail.peek = true
		count = 0
		gmail.inbox.emails.each do |mail|
			break if num == 0
			num -= 1
			file_name = "gmail_message"+count.to_s+".txt"
			count += 1
			fin = File.new(file_name, 'w+')
			message = "From: #{mail.from} \n CC: #{mail.cc} \n Subject: #{mail.subject} \n Content: #{mail.body.decoded}"
			fin.write(message)
			subject << mail.subject
			date << mail.date.to_s
			fin.close
		end
		p date
	end
	def search_by_subject
		count = 0
		p subject
		subject.each do |sub|
			p "#{count}: " + sub
			count += 1
		end
		puts "Enter your choice"
		choice = gets.chomp.to_i
		file_to_open = "gmail_message"+choice.to_s+".txt"
		fins = File.open(file_to_open, "r")
		fins.readlines.each { |f|  p f}
		fins.close
	end
	def search_by_date
		p date
		puts "Please enter the date to search yy-mm-dd"
		user_date = gets.chomp
		count = 0		
		date.each do |cdate|
			if cdate.include?user_date
				file_to_open = "gmail_message"+count.to_s+".txt"
				puts file_to_open
				fins = File.open(file_to_open, "r")
				fins.readlines.each { |f|  print f}	
				puts "\n\n\n"
				fins.close
				count += 1
			end
		end
	end
end

mailer = Mailer.new
mailer.save_to_file NO_OF_MESSAGES_TO_SAVE
mailer.search_by_subject
mailer.search_by_date
