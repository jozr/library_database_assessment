class Title

  attr_reader :name, :id

  def initialize(hash)
    @name = hash['name']
    @id = hash['id']
  end

  def save
    results = DB.exec("INSERT INTO titles (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec('SELECT * FROM titles;')
    titles = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      titles << Title.new({'name' => name, 'id' => id})
    end
  titles
  end

  def ==(another_name)
    self.name == another_name.name && self.id == another_name.id
  end

  def remove(name_input)
    result = DB.exec("SELECT * FROM titles WHERE name = '#{name_input}'")
    t_id = result.first['id'].to_i
    DB.exec("DELETE FROM contributions WHERE title_id = #{t_id}")
    DB.exec("DELETE FROM titles WHERE name = '#{name_input}'")
  end

  def self.search(title_id_input)
    results = DB.exec("SELECT authors.name FROM authors JOIN contributions ON (contributions.author_id = authors.id) JOIN titles ON (contributions.title_id = titles.id) WHERE titles.id = #{title_id_input};")
    names = []
    results.each do |result|
      names << result['name']
    end
    names
  end

end
