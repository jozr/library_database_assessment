require 'rspec_helper'

describe Title do

  it 'is initialized with a name' do
    title = Title.new({'name' => 'Tropic of Cancer'})
    title.should be_instance_of Title
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

  it 'lets you remove titles from the database' do
    title = Title.new({'name' => 'Stuff'})
    title.save
    author = Author.new({'name' => 'Jane'})
    author.save
    contribution = Contribution.new({'author_id' => author.id, 'title_id' => title.id})
    contribution.save
    title_two = Title.new({'name' => 'More stuff'})
    title_two.save
    author_two = Author.new({'name' => 'Joe'})
    author_two.save
    contribution_two = Contribution.new({'author_id' => author_two.id, 'title_id' => title_two.id})
    contribution_two.save
    Title.remove(title.id)
    Title.all.should eq [title_two]
    Contribution.all.should eq [contribution_two]
  end

  it 'searches for authors of a title' do
    author = Author.new({'name' => 'Marjane Satrapi'})
    author.save
    author_two = Author.new({'name' => 'Julie Doucet'})
    author_two.save
    title = Title.new({'name' => 'The Best Graphic Novel'})
    title.save
    contribution = Contribution.new({'author_id' => author.id, 'title_id' => title.id})
    contribution.save
    contribution_two = Contribution.new({'author_id' => author_two.id, 'title_id' => title.id})
    contribution_two.save
    Title.search(title.id).should eq ['Marjane Satrapi', 'Julie Doucet']
  end
end
