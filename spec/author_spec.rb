require 'rspec_helper'
require 'author'

describe Author do

  it 'is initialized with a name' do
    test_author = Author.new({'name' => 'Henry Miller'})
    test_author.should be_instance_of Author
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
end
