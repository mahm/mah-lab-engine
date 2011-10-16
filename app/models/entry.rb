require "yaml"

class Entry
  attr_reader :title, :slug, :content

  def initialize(str)
    content = split_entry_file(str)
    prepare_header(content[0])
    prepare_content(content[1])
  end

  def split_entry_file(str)
    str.split("\n\n", 2)
  end

  def prepare_header(header_str)
    yaml = YAML::load(header_str)
    @title = yaml["title"]
    @slug  = yaml["slug"]
  end

  def prepare_content(content_str)
    @content = content_str
  end
end
