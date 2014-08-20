class Book

  attr_reader :title_id, :author_id, :id

  def initialize(hash)
    @title_id = hash['title_id']
    @author_id = hash['author_id']
    @id = hash['id']
  end
end
