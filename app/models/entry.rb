# coding: utf-8
require "yaml"
require "iconv"

class Entry
  attr_reader :id, :date, :title, :slug, :summary, :content, :feed_url, :rel_url, :filename

  def initialize(filename, str)
    content = split_entry_file(str)
    @filename = filename
    prepare_id
    prepare_date
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
    splited = str.split("\n\n", 2)
    splited = extract_yaml_part(str) if splited.size < 2
    return splited
  end

  def extract_yaml_part(str)
    return_str = ""
    str.each_line do |line|
      return_str += (line + "\n") if line =~ /.+:.+/
    end
    return_str = "title: no title" if return_str.nil?
    [return_str.strip, ""]
  end

  def prepare_date
    seg = nil
    basename = File::basename(@filename, ".*")
    seg = basename.split("-")[0..2].map{|w| w.to_i} if basename =~ /\d+\d.+\d.+.*/
    return @date = Date.new(seg[0], seg[1], seg[2]) unless seg.nil?
    return @date = Date.new(1900, 1, 1)
  end

  def prepare_header(header_str)
    yaml = YAML::load(header_str)
    @title = (yaml["title"] || "新しいエントリ")
    @slug  = (yaml["slug"] || entry_name)
  end

  def entry_name
    date_size = 0
    @filename.split("-")[0..2].each{|w| date_size += (w.length+1)}
    filename_with_ext = @filename[date_size..@filename.length]
    return File::basename(filename_with_ext, ".*") unless filename_with_ext.nil?
    return "new-blog"
  end

  def prepare_summary(content_str)
    @summary = markdown(content_str.match(/.*\n/).to_s)
  end

  def prepare_content(content_str)
    @content = coderay(code_syntax_filter(markdown(content_str))).strip
  end

  def markdown(str)
    RDiscount.new(str, :smart).to_html
  end

  def coderay(html)
    force_change_to_utf8(html).gsub(/\<pre>\<code( lang="(.+?)")?\>(.+?)\<\/code\>\<\/pre\>/m) do
      # TODO: コードハイライトができるようにする。
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
    @feed_url = "http://blog.mah-lab.com/#{four(self.date.year)}/#{two(self.date.month)}/#{two(self.date.day)}/#{self.slug}/"
    # use html rendering
    @rel_url = "/#{four(self.date.year)}/#{two(self.date.month)}/#{two(self.date.day)}/#{self.slug}/"
  end

private
  def four(num)
    sprintf("%04d", num)
  end

  def two(num)
    sprintf("%02d", num)
  end
end
