# coding: utf-8
require "yaml"
require "iconv"

class Entry
  attr_reader :id, :date, :title, :slug, :summary, :content, :feed_url, :rel_url

  def initialize(filename, str)
    content = split_entry_file(str)
    prepare_id
    prepare_date(filename)
    prepare_header(content[0])
    prepare_summary(content[1])
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

  def prepare_summary(content_str)
    @summary = markdown(content_str.match(/.*\n/).to_s)
  end

  def prepare_content(content_str)
    @content = coderay(code_syntax_filter(markdown(content_str)))
  end

  def markdown(str)
    RDiscount.new(str, :smart).to_html
  end

  def coderay(html)
    force_change_to_utf8(html).gsub(/\<pre>\<code( lang="(.+?)")?\>(.+?)\<\/code\>\<\/pre\>/m) do
      # CodeRay.scan($3.strip, $2).div(:css => :class)
      "<pre>#{$3.strip}</pre>"
    end
  end

  def code_syntax_filter(html)
    force_change_to_utf8(html).gsub(/\<pre\>\<code\>:::(.+)/, '<pre><code lang="\1">')
  end

  def force_change_to_utf8(str)
    Iconv.new('UTF-8//IGNORE', 'UTF-8').iconv(str)
  end

  def prepare_url
    # use atom feed building
    @feed_url = "http://blog.mah-lab.com/#{four(self.date.year)}/#{two(self.date.month)}/#{two(self.date.day)}/#{self.slug}"
    # use html rendering
    @rel_url = "/#{four(self.date.year)}/#{two(self.date.month)}/#{two(self.date.day)}/#{self.slug}"
  end

private
  def four(num)
    sprintf("%04d", num)
  end

  def two(num)
    sprintf("%02d", num)
  end
end
