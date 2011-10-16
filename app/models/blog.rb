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

private
  def create_entry(filename)
    Entry.new(filename, open(filename).read)
  end
end
