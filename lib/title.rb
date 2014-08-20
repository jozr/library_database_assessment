require 'pry'

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

  def search(title_input)
    t_id_result = DB.exec("SELECT * FROM titles WHERE name = '#{title_input}'")
    t_id = t_id_result.first['id'].to_i
    c_results = DB.exec("SELECT * FROM contributions WHERE title_id = #{t_id}")
    author_ids = []
    c_results.each do |c_result|
      a_id = c_result['author_id']
      author_ids << a_id
    end

    authors = []
    author_ids.each do |author_id|
      authors << DB.exec("SELECT * FROM authors WHERE id = #{author_id}")
    end
    author_names = []
    authors.each do |author|
      author_name = author.first['name']
      author_names << author_name
    end
  author_names
  end
end
