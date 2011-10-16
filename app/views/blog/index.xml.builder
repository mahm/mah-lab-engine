atom_feed(:language => "ja-JP",
          :root_url => "http://blog.mah-lab.com/",
          :url      => "http://blog.mah-lab.com/index.xml",
          :id       => "http://blog.mah-lab.com/") do |feed|
  feed.title('blog.mah-lab.com')
  feed.updated(@entries.last.date)
  feed.author{|author| author.name("mah_lab")}

  @entries.each do |e|
    feed.entry(e,
      :url => e.feed_url,
      :id  => e.feed_url,
      :published => e.date,
      :updated => e.date) do |item|
      item.title(e.title)
      item.content(:type => 'html'){item.cdata! RDiscount.new(e.content).to_html}
      item.author{|author| author.name("mah_lab")}
    end
  end
end
