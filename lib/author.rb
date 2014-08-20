class Author

  attr_reader :name, :id

  def initialize(hash)
    @name = hash['name']
    @id = hash['id']
  end

  def save
    results = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec('SELECT * FROM authors;')
    authors = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      authors << Title.new({'name' => name, 'id' => id})
    end
  authors
  end

  def ==(another_name)
    self.name == another_name.name && self.id == another_name.id
  end

  def remove(name_input)
    result = DB.exec("SELECT * FROM authors WHERE name = '#{name_input}'")
    a_id = result.first['id'].to_i
    DB.exec("DELETE FROM contributions WHERE author_id = #{a_id}")
    DB.exec("DELETE FROM authors WHERE name = '#{name_input}'")
  end
end
