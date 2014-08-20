require 'rspec_helper'
require 'author'

describe Author do

  it 'is initialized with a name' do
    test_author = Author.new({'name' => 'Henry Miller'})
    test_author.should be_instance_of Author
  end
end
