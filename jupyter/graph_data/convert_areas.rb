#!/usr/bin/env ruby
ARGV.each do|a|
  puts "Argument: #{a}"
  if File.exist?(a)
    contents = File.read(a);
    bak = a + '.bak'
    File.rename(a, bak)
    contents = contents.lines.to_a
    contents = contents.map do | line |
      line = line.chomp! + "\n"
      unmodified_line = line
      line.gsub!(" ", "_") if line.include?(" ")
      line.gsub!(",", "_") if line.include?(",")
      line.gsub!("__", "_") if line.include?("__")
      line.chomp!
      line = "\'" + line + "\',\n"
      line
    end
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
