#!/usr/bin/env ruby

# converts the old requirements format to the new one

# Get commandline arguments
a = ARGV[0]
counties = ARGV[1..-1]
pp counties

if File.exist?(a) then
  # Read contents of the file.
  contents = File.read(a);
  # bak = a + '.bak'
  # # Make original file the backup.
  # File.rename(a, bak)

  # Create array based on lines in the file.
  contents = contents.lines.to_a

  contents = contents.map do | line |
    line_match = false
    counties.each do |county|
      line_match = true if line.include?(county)
    end
    if not line_match then
      line.gsub!(/.*/, "")
    end
    # puts line
    line.chomp!
    line
  end

  # Convert from array to string
  contents = contents.join("")
  pp contents
  new_file = File.basename(a, File.extname(a)) + "_counties.txt"
  # Write the modified contents to the file.
  File.open(new_file, 'w') {|file| file.write(contents) }
  puts "file created"

else
  puts "file does not exist"
end
