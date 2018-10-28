def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  @students = [] # create an empty array
  name = gets.chomp   # get the first name
  while !name.empty? do  # while the name is not empty, repeat this code
    @students << {:name => name, :cohort => "november"}   # add the student hash to the array
    puts "Now we have #{@students.count} students" # get another name from the user
    name = gets.chomp
  end
  return @students   # return the array of students
end

def print_header
  puts "The students of my cohort at Makers Academy"
  puts '-------------'
end

def print(students)
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer (names)
  puts "Overall, we have #{@students.count} great students"
end

students = input_students
print_header
print(students)
print_footer([students])
