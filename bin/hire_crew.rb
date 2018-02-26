print("Ship name?  ")
ship_name = gets.chomp
puts("Let's see who is looking for ship work.")

possible_crew = []
rand(3..12).times {
  f_name = ["Fred", "Joe", "Jane", "Sally", "Bekka"].sample
  l_name = ["Smith", "Jones", "Grishom", "Domici"].sample
  name = "#{f_name} " + l_name
  possible_crew << name
}

possible_crew.each_with_index { |c, i|
  print("%d %s\n" % [i, c])
}

new_crew = []

puts("Enter the Index to select or 'q' to quit.")
selection = gets.chomp
selection = selection.to_i unless selection == 'q'
until selection == 'q' do
  if selection < possible_crew.length
    new_crew << possible_crew.delete_at(selection)
  else
    puts "Sorry, that option is not available."
  end
  possible_crew.each_with_index { |c, i|
    print("%d %s\n" % [i, c])
  }
  puts("Enter the Index to select or 'q' to quit.")
  selection = gets.chomp
  selection = selection.to_i unless selection == 'q'
end

puts("Here's your new crew: ")
new_crew.each { |c|
  print(" %s\n" %  c)
}
