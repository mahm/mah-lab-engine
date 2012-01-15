# coding: utf-8
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
    @entries.sort{|a, b| b.date <=> a.date}[offset..max]
  end
  def all
    @entries.sort{|a, b| b.date <=> a.date}
  end

  def page
    (@entries.size / @@paginate.to_f).ceil
  end

  def size
    @entries.size
  end

  def entry(year, month, day, slug)
    return nil unless check_year(year) && check_month(month) && check_day(day) && check_slug(slug)
    entry_date = Date.new(year.to_i, month.to_i, day.to_i)
    entry = @entries.select {|entry| entry.date == entry_date && entry.slug == slug}
    return nil if entry.size != 1
    entry.pop
  end

  def backnumber
    @entries.sort{|a, b| b.date <=> a.date}
  end

  def archive(year, month, day)
    return nil if year.nil?
    entries = []
    if month.nil? && day.nil?
      return nil unless check_year(year)
      entries = @entries.select{|entry| entry.date.year == year.to_i}
    elsif !month.nil? && day.nil?
      return nil unless check_year(year) && check_month(month)
      entries = @entries.select{|entry| entry.date.year == year.to_i && entry.date.month == month.to_i}
    else
      return nil unless check_year(year) && check_month(month) && check_day(day)
      entries = @entries.select{|entry| entry.date.year == year.to_i && entry.date.month == month.to_i && entry.date.day == day.to_i}
    end
    return nil if entries.size < 1
    entries.sort{|a, b| b.date <=> a.date}
  end

  # 1900-4712
  def check_year(year)
    return false if year.nil?
    begin
      return true if year.to_i >= 1900 && year.to_i <= 4712
    rescue
      return false
    end
  end

  # 01-12
  def check_month(month)
    return false if month.nil?
    begin
      return true if month.to_i >= 1 && month.to_i <= 12
    rescue
      return false
    end
  end

  # 01-31
  def check_day(day)
    return false if day.nil?
    begin
      return true if day.to_i >= 1 && day.to_i <= 31
    rescue
      return false
    end
  end

  # alphabet and simbol(40 words)
  def check_slug(slug)
    return false if slug.nil?
    return false if slug.length > 40
    return true  if slug.to_s =~ /^[ -~｡-ﾟ]*$/
  end

private
  def create_entry(filename)
    Entry.new(filename, open(filename).read)
  end

end
