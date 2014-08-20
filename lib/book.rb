class Book

  attr_reader :title_id, :author_id, :id

  def initialize(hash)
    @title_id = hash['title_id']
    @author_id = hash['author_id']
    @id = hash['id']
  end

  def save
    results = DB.exec("INSERT INTO books (author_id, title_id) VALUES (#{@author_id}, #{@title_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec('SELECT * FROM books;')
    books = []
    results.each do |result|
      author_id = result['author_id'].to_i
      title_id = result['title_id'].to_i
      id = result['id'].to_i
      books << Book.new({'author_id' => author_id, 'title_id' => title_id, 'id' => id})
    end
  books
  end

  def ==(another_name)
    self.author_id == another_name.author_id && self.title_id == another_name.title_id
  end
end
