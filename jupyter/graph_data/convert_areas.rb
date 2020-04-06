#!/usr/bin/env ruby

# converts the old requirements format to the new one

# Get commandline arguments
ARGV.each do|a|
  puts "Argument: #{a}"

  if File.exist?(a)

    # Read contents of the file.
    contents = File.read(a);

    # Create backup file name
    bak = a + '.bak'
    # Make original file the backup.
    File.rename(a, bak)

    # Flag used to determine whether the file should be modified.
    prev_modified = false

    # Create array based on lines in the file.
    contents = contents.lines.to_a

    # create a variable to keep track of the line number for printing and debugging purposes
    line_number = 1

    contents = contents.map do | line |
      line = line.chomp! + "\n"
      unmodified_line = line
      if line.include?(" ")
        line.gsub!(" ", "_")
      end

      if line.include?(",")
        line.gsub!(",", "_")
      end

      if line.include?("__")
        line.gsub!("__", "_")
      end

      line.chomp!
      line = "\'" + line + "\',\n"

      line
    end
    # pp contents
    states = [
      "Alabama", "Alaska", "American Samoa", "Arizona", "Arkansas", "California", "Colorado",
      "Connecticut", "Delaware", "Florida", "Georgia", "Guam", "Hawaii",
      "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland",
      "Massachusetts", "Michigan", "Minnesota", "Mississippi",
      "Missouri", "Montana", "Nebraska", "Nevada", "New_Hampshire", "New_Jersey", "New_Mexico",
      "New_York", "North_Carolina", "North_Dakota", "Ohio",
      "Oklahoma", "Oregon", "Pennsylvania", "Puerto_Rico", "Rhode_Island", "South_Carolina",
      "South_Dakota", "Tennessee", "Texas", "Virgin_Islands", "Utah", "Vermont", "Virginia",
      "Washington", "West_Virginia", "Wisconsin", "Wyoming"
    ]
    content_states = {}
    states.each do |state|
      content_states[state] = contents.select{|entry| entry.include?(state)}
    end

    content_states.each do |k, v|
      v = v.join("")
      text = k + ".txt"
      File.open(text, 'w') {|file| file.write(v) }
    end

    # Convert from array to string
    contents = contents.join("")
    # Write the modified contents to the file.
    File.open(a, 'w') {|file| file.write(contents) }

  end
end
