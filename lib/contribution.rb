class Contribution

  attr_reader :title_id, :author_id, :id

  def initialize(hash)
    @title_id = hash['title_id']
    @author_id = hash['author_id']
    @id = hash['id']
  end

  def save
    results = DB.exec("INSERT INTO contributions (author_id, title_id) VALUES (#{@author_id}, #{@title_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec('SELECT * FROM contributions;')
    contributions = []
    results.each do |result|
      author_id = result['author_id'].to_i
      title_id = result['title_id'].to_i
      id = result['id'].to_i
      contributions << Contribution.new({'author_id' => author_id, 'title_id' => title_id, 'id' => id})
    end
  contributions
  end

  def ==(another_name)
    self.author_id == another_name.author_id && self.title_id == another_name.title_id
  end

  def self.remove(author_name_input, title_name_input)
    a_result = DB.exec("SELECT * FROM authors WHERE name = '#{author_name_input}'")
    a_id = a_result.first['id'].to_i
    t_result = DB.exec("SELECT * FROM titles WHERE name = '#{title_name_input}'")
    t_id = a_result.first['id'].to_i
    DB.exec("DELETE FROM contributions WHERE title_id = #{t_id} AND author_id = #{a_id}")
  end
end
