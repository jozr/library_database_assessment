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
      puts "PRESS 'at' TO ADD AN AUTHOR TO A TITLE"
      a_choice = gets.chomp
      if a_choice == 'aa'
        add_author
      elsif a_choice == 'la'
        list_authors
      elsif a_choice == 'at'
        add_author_to_title
      else
        puts "ENTER A VALID KEY"
      end

    elsif main_choice == 't'
      puts "PRESS 'at' TO ADD A TITLE"
      puts "PRESS 'lt' TO LIST TITLES"
      a_choice = gets.chomp
      if a_choice == 'at'
        add_title
      elsif a_choice == 'lt'
        list_titles
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
    puts "#{author.id}: #{author.name}"
  end
end

def add_author_to_title
  list_authors
  puts "ENTER AN AUTHOR ID"
  author_input = gets.chomp
  list_titles
  puts "ENTER TITLE ID"
  title_input = gets.chomp
  DB.exec("INSERT INTO contributions (author_id, title_id) VALUES (#{author_input}, #{title_input})")
  puts "CONTRIBUTION ADDED"
end

def add_title
  puts "ENTER TITLE NAME"
  name_input = gets.chomp
  title = Title.new({'name' => name_input})
  title.save
  puts "'#{name_input}' HAS BEEN ADDED."
end

def list_titles
  puts '********** TITLES **********'
  Title.all.each do |title|
    puts "#{title.id}: #{title.name}"
  end
end

welcome
