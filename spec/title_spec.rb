require 'rspec_helper'
require 'title'

describe Title do

  it 'is initialized with a name' do
    test_title = Title.new({'name' => 'Tropic of Cancer'})
    test_title.should be_instance_of Title
  end

  it 'lets you save multiple titles to the database' do
    title = Title.new({'name' => 'Persepolis'})
    title.save
    title_two = Title.new({'name' => 'My New York Diary'})
    title_two.save
    Title.all.should eq [title, title_two]
  end

  it 'treats titles as equal if name and id match' do
    title = Title.new({'name' => 'Stuff', 'id' => 1})
    title_two = Title.new({'name' => 'Stuff', 'id' => 1})
    title.should eq title_two
  end
end
