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
end
