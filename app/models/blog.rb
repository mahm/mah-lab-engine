require "singleton"

class Blog
  include Singleton

  attr_reader :entries

  # when you test this class, change this class variable
  @@basepath = "/app/assets/entries/"
  def source_directory
    Dir::pwd + @@basepath
  end

  def initialize
    @entries = []
    Dir.glob(source_directory + "*.mkd").each do |filename|
      @entries << create_entry(filename)
    end
  end

  @@paginate = 5
  def entries(page)
    offset = @@paginate * (page - 1) > (self.size - 1) ? @@paginate * (self.page - 1) : @@paginate * (page - 1)
    max = offset + @@paginate > (self.size - 1) ? (self.size - 1) : offset + @@paginate - 1
    @entries.reverse[offset..max]
  end

  def page
    (@entries.size / @@paginate.to_f).ceil
  end

  def size
    @entries.size
  end

private
  def create_entry(filename)
    Entry.new(filename, open(filename).read)
  end

end
