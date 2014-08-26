require 'pg'
require './lib/author.rb'
require './lib/contribution.rb'
require './lib/title.rb'
require 'pry'

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
      puts "PRESS 'da' TO DELETE AN AUTHOR"
      a_choice = gets.chomp
      if a_choice == 'aa'
        add_author
      elsif a_choice == 'la'
        list_authors
      elsif a_choice == 'da'
        delete_author
      else
        puts "ENTER A VALID KEY"
      end

    elsif main_choice == 't'
      puts "PRESS 'at' TO ADD A TITLE"
      puts "PRESS 'lt' TO LIST TITLES"
      puts "PRESS 'dt' TO DELETE A TITLE"
      a_choice = gets.chomp
      if a_choice == 'at'
        add_title
      elsif a_choice == 'lt'
        list_titles
      elsif a_choice == 'dt'
        delete_title
      else
        puts "ENTER A VALID KEY"
      end

    elsif main_choice == 'c'
      puts "PRESS 'ac' TO ADD A CONTRIBUTION OR 'dc' TO DELETE A CONTRIBUTION"
      puts "PRESS 'lt' TO LIST ALL TITLES AN AUTHOR CONTRIBUTED TO"
      puts "PRESS 'la' TO LIST ALL AUTHORS WHO CONTRIBUTED TO A TITLE"
      puts "PRESS 'lc' TO LIST CONTRIBUTIONS"
      c_choice = gets.chomp
      if c_choice == 'ac'
        add_contribution
      elsif c_choice == 'dc'
        remove_contribution
      elsif c_choice == 'lt'
        list_titles_by_author
      elsif c_choice == 'la'
        list_authors_by_title
      elsif c_choice == 'lc'
        list_contributions
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

def delete_author
  list_authors
  puts "ENTER AN AUTHOR ID"
  author_input = gets.chomp
  Author.remove(author_input)
  puts "DELETED"
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

def delete_title
  list_titles
  puts "ENTER A TITLE ID"
  title_input = gets.chomp
  Title.remove(title_input)
  puts "TITLE DELETED"
end

def add_contribution
  list_authors
  puts "ENTER AN AUTHOR ID"
  author_input = gets.chomp
  list_titles
  puts "ENTER TITLE ID"
  title_input = gets.chomp
  DB.exec("INSERT INTO contributions (author_id, title_id) VALUES (#{author_input}, #{title_input})")
  puts "CONTRIBUTION ADDED"
end

def list_titles_by_author
  list_authors
  puts "ENTER AN AUTHOR ID"
  author_input = gets.chomp
  puts "*** CONTRIBUTING TITLE(S) ***"
  puts Author.search(author_input)
end

def list_authors_by_title
  list_titles
  puts "ENTER A TITLE ID"
  title_input = gets.chomp
  puts "*** CONTRIBUTING AUTHOR(S) ***"
  puts Title.search(title_input)
end

def list_contributions
  contributions = Contribution.all
  contributions.each do |contribution|
    author = DB.exec("SELECT * FROM authors WHERE id = #{contribution.author_id}")
    title = DB.exec("SELECT * FROM titles WHERE id = #{contribution.title_id}")
    puts "#{contribution.id}: #{author.first['name']} - #{title.first['name']}"
  end
end

def remove_contribution
  list_contributions
  puts "ENTER THE CONTRIBUTION ID"
  input_id = gets.chomp
  Contribution.remove(input_id)
  puts "CONTRIBUTION DELETED"
end

welcome
