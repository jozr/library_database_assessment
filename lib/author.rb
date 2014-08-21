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
      authors << Author.new({'name' => name, 'id' => id})
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

  def self.search(author_input)
    a_id_result = DB.exec("SELECT * FROM authors WHERE name = '#{author_input}'")
    a_id = a_id_result.first['id'].to_i
    c_results = DB.exec("SELECT * FROM contributions WHERE author_id = #{a_id}")
    title_ids = []
    c_results.each do |c_result|
      t_id = c_result['title_id']
      title_ids << t_id
    end

    titles = []
    title_ids.each do |title_id|
      titles << DB.exec("SELECT * FROM titles WHERE id = #{title_id}")
    end
    title_names = []
    titles.each do |title|
      title_name = title.first['name']
      title_names << title_name
    end
  title_names
  end
end
