require "yaml"

class Entry
  attr_reader :date, :title, :slug, :content

  def initialize(filename, str)
    content = split_entry_file(str)
    prepare_date(filename)
    prepare_header(content[0])
    prepare_content(content[1])
  end

  def split_entry_file(str)
    str.split("\n\n", 2)
  end

  def prepare_date(filename)
    seg = File::basename(filename, ".*").split("-")[0..2].map{|w| w.to_i}
    @date = Date.new(seg[0], seg[1], seg[2])
  end

  def prepare_header(header_str)
    yaml = YAML::load(header_str)
    @title = yaml["title"]
    @slug  = yaml["slug"]
  end

  def prepare_content(content_str)
    @content = RDiscount.new(content_str).to_html
  end

end
