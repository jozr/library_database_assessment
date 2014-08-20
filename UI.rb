require 'pg'
require './lib/author.rb'
require './lib/contribution.rb'
require './lib/title.rb'

DB = PG.connect({:dbname => 'library'})

def welcome
  puts '********************* LIBRARY *********************'
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Press 'aa' to add an author"
    puts "Press 'x' to exit"
    choice = gets.chomp
    case choice
    when 'aa'
      add_author
    when 'x'
      exit
    else
      puts 'CHOOSE AN OPTION ABOVE'
    end
  end
end

def add_author
  puts "ENTER AUTHOR NAME"
  name_input = gets.chomp
  author = Author.new({'name' => name_input})
  author.save
  puts "'#{name_input}' has been added."
end

welcome
