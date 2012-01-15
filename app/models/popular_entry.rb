require 'net/http'
require 'uri'
class PopularEntry < ActiveRecord::Base
  scope :popular_entries, order("bookmark_count DESC").limit(10)
  HB_URL = "http://api.b.st-hatena.com/entry.count?url="
  def self.reload
    ActiveRecord::Base.transaction do
      Blog.instance.all.each do |entry|
        bookmark_count = Net::HTTP.get(URI.parse(HB_URL + ERB::Util.url_encode(entry.feed_url)))
        entry_instance = PopularEntry.find_or_initialize_by_url(entry.feed_url)
        entry_instance.title = entry.title
        entry_instance.publish_date = entry.date
        entry_instance.bookmark_count = bookmark_count.blank? ? 0 : bookmark_count
        entry_instance.save!
      end
    end
  end
  def self.archive_year_month_list
    PopularEntry.group(:year, :month).order("year DESC, month DESC").count(:url).map do |k, v|
      {
        :label => k.join("."),
        :url => k.map{|m| m < 10 ? "0" + m.to_s : m}.join("/"),
        :count => v
      }
    end
  end

  before_save :apply_year_month
  def apply_year_month
    self.year = self.publish_date.year
    self.month = self.publish_date.month
  end
end
