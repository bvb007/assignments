require 'gmail'
require 'io/console'

class GmailArchiver
  attr_accessor :gmail
  def initialize username, password
    @gmail = Gmail.new(username, password);
  end
  def save_to_file num, index_file_name
    gmail.peek = true
    count = 0
    index_file = File.open(index_file_name, 'a+')
    gmail.inbox.emails.each do |mail|
      break if num == 0
      outfile_name = Time.now.strftime("%H:%M:%S--%y:%m:%d").to_s+"_gmail_inbox.txt"
      while(File.exists?(outfile_name))
        outfile_name = Time.now.strftime("%H:%M:%S--%y:%m:%d").to_s+"_gmail_inbox_" + count.to_s+".txt";
        count += 1;
      end      
      num -= 1
      output_file = File.new(outfile_name, 'w+')
      index_save_string = "#{outfile_name}##-->#{mail.subject}##-->#{mail.date.to_s.split('T').at(0)}##-->\n"
      index_file.write(index_save_string)
      message = "From: #{mail.from} \n CC: #{mail.cc} \n Subject: #{mail.subject} \n Content: #{mail.body.decoded}"
      output_file.write(message)
      output_file.close  
    end
    index_file.close
    puts "Mails saved successfully!!\n"
    gmail.logout
  end
end

class ArchiveSearcher
  def search search_for, search_item, index_file_name
    search_result = []
    search_index = (search_for=='subject') ? 1:2
    File.open(index_file_name, 'r').each do |line|
      line_array = line.split('##-->')
      search_result<<line_array[0] if line_array[search_index] == search_item
    end
    if search_result.empty? 
      puts "No records found!!\n\n"
    else
      search_result.each do |file_name|
        puts File.open(file_name).read
      end
    end
  end
end

class ArchiveManager
  attr_accessor :index_file_name, :no_of_mails_to_fetch
  def initialize num
    @index_file_name = Time.now.strftime("%H:%M:%S--%y:%m:%d").to_s + "_gmail_index.txt"
    @no_of_mails_to_fetch = num  
  end
  def search
    gmail_searcher = ArchiveSearcher.new
    begin
      puts "----------------------\n1: Search by subject \n2: Search by date \n3: Exit \nEnter your choice"
      choice = gets.chomp.to_i
      case choice
      when 1
        puts "Enter the subject to be searched: "
        gmail_searcher.search "subject", gets.chomp, index_file_name
      when 2
        puts "Enter the date to be searched: "
        gmail_searcher.search "date", gets.chomp, index_file_name
      end
    end while choice != 3
  end
  def start
    puts "Enter the username and password for gmail account: "
    uname = gets.chomp
    pass  = STDIN.noecho(&:gets)
    puts "Please wait... Connecting..."
    gmail = GmailArchiver.new(uname, pass)
    gmail.save_to_file no_of_mails_to_fetch, index_file_name
  end
end

NO_OF_MAILS_TO_SAVE = 5
gmail = ArchiveManager.new NO_OF_MAILS_TO_SAVE
begin
  gmail.start
rescue => msg
  puts "Error --> #{msg}"
  abort('Exiting now!!')
end
gmail.search