@students = []

def interactive_menu
  loop do
    print_menu
    main_menu_process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "------ Main Menu -------"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
  puts "------------------------"
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
  puts "----- Student Menu -----"
  puts "1. Show all students"
  puts "2. Show students with a custom search filter"
  puts "------------------------"
end

def student_menu_process(selection)
  case selection
    when "1"
      show_students
    when "2"
      student_search
  end
end


def student_search
  puts "What letter would you like to search by?"
  first_letter = gets.chomp.upcase
  counter = 0
  @students.each_with_index do |student, index|
    if student[:name][0] == first_letter
      puts "#{counter += 1} #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end


def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    @students << {name: name, cohort: :november}
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
  @students
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
    puts "#{index+1} #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name,cohort = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym}
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
