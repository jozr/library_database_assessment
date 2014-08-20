require 'rspec_helper'
require 'book'

describe Book do

  it 'is initialized with a name' do
    test_book = Book.new({'author_id' => 1, 'title_id' => 3})
    test_book.should be_instance_of Book
  end

  it 'lets you save multiple books to the database' do
    book = Book.new({'author_id' => 2, 'title_id' => 5})
    book.save
    book_two = Book.new({'author_id' => 2, 'title_id' => 9})
    book_two.save
    Book.all.should eq [book, book_two]
  end

  it 'treats books as equal if author id and title id match' do
    book = Book.new({'author_id' => 3, 'title_id' => 4})
    book_two = Book.new({'author_id' => 3, 'title_id' => 4})
    book.should eq book_two
  end
end
