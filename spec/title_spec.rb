require 'rspec_helper'
require 'title'

describe Title do

  it 'is initialized with a name' do
    test_title = Title.new({'name' => 'Tropic of Cancer'})
    test_title.should be_instance_of Title
  end

end
