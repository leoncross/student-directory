@students = []

def interactive_menu
  loop do
    print_menu
    main_menu_process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "------ Main Menu -------".center(70)
  puts "1. Input the students".center(70)
  puts "2. Show the students".center(70)
  puts "3. Save the list to students.csv".center(70)
  puts "4. Load the list from students.csv".center(70)
  puts "9. Exit".center(70)
  puts "------------------------".center(70)
end

def main_menu_process(selection)
  case selection
  when "1"
    input_students
  when "2"
    print_student_menu
    student_menu_process(STDIN.gets.chomp)
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "invalid selection, try again"
  end
end

def print_student_menu
  puts "----- Student Menu -----".center(70)
  puts "1. Show all students".center(70)
  puts "2. Search students by first letter".center(70)
  puts "3. Search students by length of name".center(70)
  puts "9. Exit to main menu".center(70)
  puts "------------------------".center(70)
end

def student_menu_process(selection)
  case selection
    when "1"
      show_students
    when "2"
      student_search_first_letter
    when "3"
      student_search_name_length
    when "9"
      interactive_menu
  end
end

def student_search_first_letter
  puts "What letter would you like to search by?"
  first_letter = STDIN.gets.chomp
  counter = 0
  @students.each_with_index do |student|
    if student[:name][0] == first_letter
      puts "#{counter += 1} #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
  search_students_again
end

def student_search_name_length
  puts "How many letters would you like to search by?"
  length = STDIN.gets.chomp.to_i
  counter = 0
  @students.each_with_index do |student|
    if student[:name].length <= length
      puts "#{counter += 1} #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
  search_students_again
end

def search_students_again
  puts "Would you like to go back to the student search menu? (Y/N)"
  answer = STDIN.gets.chomp.upcase
  if answer == "Y"
    print_student_menu
    student_menu_process(STDIN.gets.chomp)
  end
end

def show_students
  print_header
  print_students_list
  print_footer
end

def print_header
  puts "The students of Villains Academy"
  puts "--------------"
end

def print_students_list()
  @students.each_with_index do |student, index|
    puts "#{index+1} Name: #{student[:name]} from #{student[:country]}, whose favourite activity is #{student[:hobby]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  putting_student_and_students
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:country], student[:hobby], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def input_students
  puts "Please enter the names of the students, their country of birth,"
  puts "favourite hobby, and their cohort if applicable"
  puts "To finish, just hit return twice"
  puts "-----------"
  puts "Enter the name of the student:"
  name = STDIN.gets.chomp
  puts "Enter their country of birth:"
  country = STDIN.gets.chomp
  puts "Enter their favourite hobby:"
  hobby = STDIN.gets.chomp
  puts "Finally, enter their cohort (No need if November, just press enter):"
  cohort = STDIN.gets.chomp
  cohort = "november" if cohort.empty?
  while !name.empty? do
    @students << {name: name, country: country, hobby: hobby, cohort: cohort}
    putting_student_and_students
    name = STDIN.gets.chomp
  end
  @students
end

def putting_student_and_students
  if @students.count < 2
    puts "In total, we have #{@students.count} student"
  else
    puts "In total, we have #{@students.count} students"
  end
end


def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name,hobby,cohort = line.chomp.split(",")
    @students << {name: name, hobby: hobby, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

try_load_students
interactive_menu
