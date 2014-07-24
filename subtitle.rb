# Program to delay or advance time in a subtitle file(.srt) 
# Takes a .srt file as input and outputs .srt file after processing

require 'time'

def process_time(option, second, millisecond, t1, t2)
  time1 = Time.parse(t1);
  time2 = Time.parse(t2);
  ms = sprintf('%03d', millisecond);
  if option == 'delay'
    time1 -= "#{second}.#{ms}".to_f
    time2 -= "#{second}.#{ms}".to_f
    return[ time1.strftime("%H:%M:%S,%L"), time2.strftime("%H:%M:%S,%L") ];
  else
    time1 += "#{second}.#{ms}".to_f
    time2 += "#{second}.#{ms}".to_f
    return[ time1.strftime("%H:%M:%S,%L"), time2.strftime("%H:%M:%S,%L") ];   
  end  
end


def process_subtitle(fin, o, s, ms)  
  extn = File.extname  fin       
  name = File.basename fin, extn
  count = 0;
  outfile_name = name + "_new"+ extn;
  while(File.exists?(outfile_name))
    outfile_name = name + "_new" + count.to_s+extn;
    count = count + 1;
  end
  out = File.new(outfile_name, "w");
  
  file_array = fin.readlines;
  file_array.each do |line|
    if ( line.match(/0\d:\d\d:\d\d,\d\d\d[.]*/))
      line_striped = line.rstrip;
      time1 = line_striped[0,12];
      time2 = line_striped[-12..-1];
      times = process_time(o, s, ms, time1, time2);
      str = "#{times[0]} --> #{times[1]}}\n"
      out.write(str)
    else
      out.write(line);
    end
  end
  puts "Completed successfully: output file: #{outfile_name}";
end




def subtitle 
  puts "Enter the input file name(only srt)";
  input_file = gets.chomp;
  if File.exists?(input_file)
    fin = File.open(input_file, "r");
    puts "Do you want to delay or advance the time: ";
    puts "Enter 'D' to delay or 'A' to advance";
    user_option = gets.chomp;
    until(user_option == 'd' || user_option =='D' || user_option =='a' || user_option =='A')
      puts "Invalid input!! Try again 'D' for delay and 'A' to advance";
      user_option = gets.chomp;
    end
    option = (user_option == 'd' || user_option == 'D') ? 'delay' : 'advance';
    puts "Enter how many seconds you want to #{option} subtitile";
    seconds = gets.chomp.to_i;
    puts "Enter how many milli seconds you want to #{option} subtitile";
    milli_seconds = gets.chomp.to_i;
    process_subtitle(fin, option, seconds, milli_seconds);
  else
    puts "Error!! The file is not found";
  end
end


subtitle



