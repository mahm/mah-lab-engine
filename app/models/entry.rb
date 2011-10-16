require "sequence"
require "yaml"

class Entry
  attr_reader :id, :date, :title, :slug, :content, :feed_url, :rel_url

  def initialize(filename, str)
    content = split_entry_file(str)
    prepare_id
    prepare_date(filename)
    prepare_header(content[0])
    prepare_content(content[1])
    prepare_url
  end

  def prepare_id
    # use atom feed building
    @id = 1
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
    @content = content_str
  end

  def prepare_url
    # use atom feed building
    @feed_url = "http://blog.mah-lab.com/#{four(self.date.year)}/#{two(self.date.month)}/#{two(self.date.day)}/#{self.slug}"
    # use html rendering
    @rel_url = "#{four(self.date.year)}/#{two(self.date.month)}/#{two(self.date.day)}/#{self.slug}"
  end

private
  def four(num)
    sprintf("%04d", num)
  end

  def two(num)
    sprintf("%02d", num)
  end
end
