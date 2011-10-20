module BlogHelper
  def full_url(feed_url)
    feed_url
  end
  def hatena_url(feed_url)
    "http://b.hatena.ne.jp/entry/" + full_url(feed_url)
  end
  def facebook_url(feed_url)
    full_url(feed_url)
  end
end
