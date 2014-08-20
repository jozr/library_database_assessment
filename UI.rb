require 'lib/author.rb'
require 'lib/contribution.rb'
require 'lib/title.rb'

def welcome
  puts '********************* LIBRARY *********************'
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Press 'aa' to add a book"
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
