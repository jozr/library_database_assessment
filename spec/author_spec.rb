require 'rspec_helper'

describe Author do

  it 'is initialized with a name' do
    author = Author.new({'name' => 'Henry Miller'})
    author.should be_instance_of Author
  end

  it 'lets you save multiple titles to the database' do
    author = Author.new({'name' => 'Marjane Satrapi'})
    author.save
    author_two = Author.new({'name' => 'Julie Doucet'})
    author_two.save
    Author.all.should eq [author, author_two]
  end

  it 'treats authors as equal if name and id match' do
    author = Author.new({'name' => 'Virginia Woolf', 'id' => 1})
    author_two = Author.new({'name' => 'Virginia Woolf', 'id' => 1})
    author.should eq author_two
  end

  it 'lets you remove authors from the database' do
    title = Title.new({'name' => 'Stuff'})
    title.save
    author = Author.new({'name' => 'Jane'})
    author.save
    book = Book.new({'author_id' => author.id, 'title_id' => title.id})
    book.save
    title_two = Title.new({'name' => 'More stuff'})
    title_two.save
    author_two = Author.new({'name' => 'Joe'})
    author_two.save
    book_two = Book.new({'author_id' => author_two.id, 'title_id' => title_two.id})
    book_two.save
    author.remove('Jane')
    Author.all.should eq [author_two]
    Book.all.should eq [book_two]
  end
end
