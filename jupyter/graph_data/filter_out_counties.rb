#!/usr/bin/env ruby

# Get commandline arguments
a = ARGV[0]
counties = ARGV[1..-1]

if File.exist?(a) then
  # Read contents of the file.
  contents = File.read(a);
  # Create array based on lines in the file.
  contents = contents.lines.to_a
  contents = contents.map do | line |
    line_match = false
    counties.each do |county|
      line_match = true if line.include?(county)
    end
    line.gsub!(/.*/, "") unless line_match
    line.chomp!
    line
  end
  # Convert from array to string
  contents = contents.join("")
  new_file = File.basename(a, File.extname(a)) + "_counties.txt"
  # Write the modified contents to the file.
  File.open(new_file, 'w') {|file| file.write(contents) }
  puts "file created"
else
  puts "file does not exist"
end
