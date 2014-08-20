require 'rspec_helper'
require 'book'

describe Book do

  it 'is initialized with a name' do
    test_book = Book.new({'author_id' => 1, 'book_id' => 1})
    test_book.should be_instance_of Book
  end
end
