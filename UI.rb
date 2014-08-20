require 'pg'
require './lib/author.rb'
require './lib/contribution.rb'
require './lib/title.rb'

DB = PG.connect({:dbname => 'library'})

def welcome
  puts '********************** LIBRARY **********************'
  menu
end

def menu
  loop do
    puts "PRESS (a)uthors, (t)itles, (c)ontributions OR e(x)it"
    main_choice = gets.chomp
    if main_choice == 'a'
      puts "PRESS 'aa' TO ADD AN AUTHOR"
      puts "PRESS 'la' TO LIST AUTHORS"
      a_choice = gets.chomp
      if a_choice == 'aa'
        add_author
      elsif a_choice == 'la'
        list_authors
      else
        puts "ENTER A VALID KEY"
      end
    elsif main_choice == 'x'
      exit
    end
  end
end

def add_author
  puts "ENTER AUTHOR NAME"
  name_input = gets.chomp
  author = Author.new({'name' => name_input})
  author.save
  puts "'#{name_input}' HAS BEEN ADDED."
end

def list_authors
  puts '********** AUTHORS **********'
  Author.all.each do |author|
    puts author.name
  end
end

welcome
