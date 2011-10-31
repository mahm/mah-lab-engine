# coding: utf-8
require 'spec_helper'

normal_entry = <<"EOS"
title: タイトル
slug: title

titleとslugがセットされたエントリ
EOS
title_only_entry = <<"EOS"
title: タイトル

titleのみのエントリ
EOS
slug_only_entry = <<"EOS"
slug: title

slugのみのエントリ
EOS
ng01_entry = <<"EOS"
title: YAMLとの行間が空いていない
YAMLとの行間が空いていない。
EOS
describe Entry do
  describe :initialize do
    context "titleとslugが設定されている" do
      subject { Entry.new("2011-10-20-new-blog.mkd", normal_entry) }
      it { subject.title.should == "タイトル" }
      it { subject.slug.should == "title" }
      it { subject.content.strip.should == "<p>titleとslugがセットされたエントリ</p>" }
      it { subject.summary.strip.should == "<p>titleとslugがセットされたエントリ</p>" }
      it { subject.date.year.should == 2011 }
      it { subject.date.month.should == 10 }
      it { subject.date.day.should == 20 }
      it { subject.feed_url.should == "http://blog.mah-lab.com/2011/10/20/title/" }
      it { subject.rel_url.should == "/2011/10/20/title/" }
      it { subject.filename.should == "2011-10-20-new-blog.mkd" }
    end
    context "titleのみ設定されている" do
      subject { Entry.new("2011-1-02-new-blog.mkd", title_only_entry) }
      it { subject.title.should == "タイトル" }
      it { subject.slug.should == "new-blog" }
      it { subject.content.strip.should == "<p>titleのみのエントリ</p>" }
      it { subject.summary.strip.should == "<p>titleのみのエントリ</p>" }
      it { subject.date.year.should == 2011 }
      it { subject.date.month.should == 1 }
      it { subject.date.day.should == 2 }
      it { subject.feed_url.should == "http://blog.mah-lab.com/2011/01/02/new-blog/" }
      it { subject.rel_url.should == "/2011/01/02/new-blog/" }
      it { subject.filename.should == "2011-1-02-new-blog.mkd" }
    end
    context "slugのみ設定されている" do
      subject { Entry.new("2011-10-2-new-blog.mkd", slug_only_entry) }
      it { subject.title.should == "新しいエントリ" }
      it { subject.slug.should == "title" }
      it { subject.content.strip.should == "<p>slugのみのエントリ</p>" }
      it { subject.summary.strip.should == "<p>slugのみのエントリ</p>" }
      it { subject.date.year.should == 2011 }
      it { subject.date.month.should == 10 }
      it { subject.date.day.should == 2 }
      it { subject.feed_url.should == "http://blog.mah-lab.com/2011/10/02/title/" }
      it { subject.rel_url.should == "/2011/10/02/title/" }
      it { subject.filename.should == "2011-10-2-new-blog.mkd" }
    end
    context "YAML部分との行間が空いていない" do
      subject { Entry.new("2011-10-2", ng01_entry) }
      it { subject.title.should == "YAMLとの行間が空いていない" }
      it { subject.slug.should == "new-blog" }
      it { subject.content.should == "" }
    end
    context "ファイル名に日付がない" do
      subject { Entry.new("test", ng01_entry) }
      it { subject.slug.should == "test" }
      it { subject.date.year.should == 1900 }
      it { subject.date.month.should == 1 }
      it { subject.date.day.should == 1 }
    end
  end
end

